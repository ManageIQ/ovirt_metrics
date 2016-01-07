require "ovirt_metrics/version"
require "ovirt_metrics/column_definitions"
require "ovirt_metrics/nic_metrics"

$:.push File.expand_path(File.dirname(__FILE__))
require 'ovirt_metrics/models/ovirt_history'
Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "ovirt_metrics", "models", "*.rb"))) { |f| require "ovirt_metrics/models/#{File.basename(f, ".*")}" }

module OvirtMetrics
  DEFAULT_HISTORY_DATABASE_NAME     = "ovirt_engine_history".freeze
  DEFAULT_HISTORY_DATABASE_NAME_3_0 = "rhevm_history".freeze
  VM_NOT_RUNNING                    = 0

  def self.establish_connection(opts)
    self.connect(opts)
  end

  def self.connect(opts)
    opts            ||= {}
    opts[:port]     ||= 5432
    opts[:database] ||= DEFAULT_HISTORY_DATABASE_NAME
    opts[:adapter]    = 'postgresql'

    # Don't allow accidental connections to localhost.  A blank host will
    # connect to localhost, so don't allow that at all.
    host = opts[:host].to_s.strip
    raise ArgumentError, "host cannot be blank"            if host.empty?
    raise ArgumentError, "host cannot be set to localhost" if ["localhost", "localhost.localdomain", "127.0.0.1", "0.0.0.0"].include?(host)

    OvirtHistory.establish_connection(opts)
  end

  def self.connected?
    OvirtHistory.connection.active?
  end

  def self.disconnect
    OvirtHistory.connection.disconnect!
  end

  def self.vm_realtime(vm_id, start_time = nil, end_time = nil)
    metrics      = query_vm_realtime_metrics(vm_id, start_time, end_time)
    disk_metrics = query_vm_disk_realtime_metrics(vm_id, start_time, end_time)
    nic_metrics  = query_vm_nic_realtime_metrics(vm_id, start_time, end_time)
    vm_realtime_metrics_to_hashes(metrics, disk_metrics, nic_metrics)
  end

  def self.host_realtime(host_id, start_time = nil, end_time = nil)
    metrics      = query_host_realtime_metrics(host_id, start_time, end_time).all
    nic_metrics  = query_host_nic_realtime_metrics(host_id, start_time, end_time)
    host_realtime_metrics_to_hashes(metrics, nic_metrics)
  end

  private

  def self.query_host_realtime_metrics(host_id, start_time = nil, end_time = nil)
    HostSamplesHistory.where(:host_id => host_id).includes(:host_configuration).with_time_range(start_time, end_time)
  end

  def self.query_host_nic_realtime_metrics(host_id, start_time = nil, end_time = nil)
    nic_ids = HostInterfaceConfiguration.where(:host_id => host_id).collect(&:host_interface_id)
    HostInterfaceSamplesHistory.where(:host_interface_id => nic_ids).with_time_range(start_time, end_time)
  end

  def self.host_realtime_metrics_to_hashes(metrics, nic_metrics)
    related_metrics = { }
    related_metrics[:nic]  = nic_metrics.group_by  { |m| m.history_datetime }

    metrics_to_hashes(metrics, related_metrics, HOST_COLUMN_DEFINITIONS, :host_metric_to_href)
  end

  def self.query_vm_realtime_metrics(vm_id, start_time = nil, end_time = nil)
    VmSamplesHistory.where(:vm_id => vm_id).includes(:host_configuration).with_time_range(start_time, end_time)
  end

  def self.query_vm_disk_realtime_metrics(vm_id, start_time = nil, end_time = nil)
    disk_ids = DisksVmMap.where(:vm_id => vm_id).collect(&:vm_disk_id)
    VmDiskSamplesHistory.where(:vm_disk_id => disk_ids).with_time_range(start_time, end_time)
  end

  def self.query_vm_nic_realtime_metrics(vm_id, start_time = nil, end_time = nil)
    nic_ids = VmInterfaceConfiguration.where(:vm_id => vm_id).collect(&:vm_interface_id)
    VmInterfaceSamplesHistory.where(:vm_interface_id => nic_ids).with_time_range(start_time, end_time)
  end

  def self.vm_realtime_metrics_to_hashes(metrics, disk_metrics, nic_metrics)
    related_metrics = { }
    related_metrics[:disk] = disk_metrics.group_by { |m| m.history_datetime }
    related_metrics[:nic]  = nic_metrics.group_by  { |m| m.history_datetime }

    metrics_to_hashes(metrics, related_metrics, VM_COLUMN_DEFINITIONS, :vm_metric_to_href)
  end

  def self.vm_metric_to_href(metric)
    "/api/vms/#{metric.vm_id}"
  end

  def self.host_metric_to_href(metric)
    "/api/hosts/#{metric.host_id}"
  end

  def self.metrics_to_hashes(metrics, related_metrics, column_definitions, href_method)
    counters_by_id              = {}
    counter_values_by_id_and_ts = {}

    metrics.each do |metric|
      options = { :metric => metric }
      related_metrics.each { |key, related_metric| options[key] = related_metric[metric.history_datetime] }

      href = self.send(href_method, metric)

      counters_by_id[href] ||= {}
      values = {}

      column_definitions.each do |evm_col, info|
        next if column_definitions == VM_COLUMN_DEFINITIONS && options[:metric].vm_status.to_i == VM_NOT_RUNNING

        counters_by_id[href][info[:ovirt_key]] ||= info[:counter]
        values[info[:ovirt_key]] = info[:ovirt_method].call(options)
      end

      # For (temporary) symmetry with VIM API having 20-second intervals
      counter_values_by_id_and_ts[href] ||= {}
      [0, 20, 40].each do |t|
        counter_values_by_id_and_ts[href][(metric.history_datetime + t).utc.iso8601] = values
      end
    end

    return counters_by_id, counter_values_by_id_and_ts
  end
end
