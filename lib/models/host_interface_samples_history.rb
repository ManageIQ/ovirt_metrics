module OvirtMetrics
  class HostInterfaceSamplesHistory < OvirtHistory
    belongs_to :host_interface_configuration,   :foreign_key => :host_interface_configuration_version

    def self.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
      NicMetrics.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
    end

  end
end