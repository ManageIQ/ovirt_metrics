module OvirtMetrics
  class VmConfiguration < OvirtHistory
    belongs_to :cluster_configuration, :foreign_key => :cluster_configuration_version
    belongs_to :host_configuration,    :foreign_key => :default_host_configuration_version

    has_many :vm_interface_configurations, :foreign_key => :vm_configuration_version
  end
end