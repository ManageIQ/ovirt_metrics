module OvirtMetrics
  class VmDiskSamplesHistory < OvirtHistory
    belongs_to :vm_disk_configuration,   :foreign_key => :vm_disk_configuration_version

    def self.disk_usage_rate_average_in_kilobytes_per_second(disk_metrics)
      count = 0
      sum   = 0
      disk_metrics ||= []
      disk_metrics.each do |d|
        sum   += d.read_rate_bytes_per_second.to_f + d.write_rate_bytes_per_second.to_f
        count += 1
      end

      return 0.0 if count == 0
      (sum / count) / 1024
    end
  end
end