module OvirtMetrics
  class HostInterfaceSamplesHistory < OvirtHistory
    extend NicMetrics

    belongs_to :host_interface_configuration,   :foreign_key => :host_interface_configuration_version
  end
end