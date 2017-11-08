module OvirtMetrics
  class HostConfiguration < OvirtHistory
    has_many :host_interface_configurations, :foreign_key => :host_configuration_version

    belongs_to :cluster_configuration, :foreign_key => :cluster_configuration_version
  end
end