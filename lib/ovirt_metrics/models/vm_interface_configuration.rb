module OvirtMetrics
  class VmInterfaceConfiguration < OvirtHistory
    belongs_to :vm_configuration,               :foreign_key => :vm_configuration_version
    has_many   :vm_interface_samples_histories, :foreign_key => :vm_interface_configuration_version
  end
end