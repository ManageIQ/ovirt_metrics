module OvirtMetrics
  class VmInterfaceSamplesHistory < OvirtHistory
    belongs_to :vm_interface_configuration,   :foreign_key => :vm_interface_configuration_version

    def self.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
      NicMetrics.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
    end

  end
end