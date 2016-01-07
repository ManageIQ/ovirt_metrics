module OvirtMetrics
  class VmInterfaceSamplesHistory < OvirtHistory
    extend NicMetrics

    belongs_to :vm_interface_configuration,   :foreign_key => :vm_interface_configuration_version
  end
end