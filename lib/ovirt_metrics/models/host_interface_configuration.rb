module OvirtMetrics
  class HostInterfaceConfiguration < OvirtHistory
    belongs_to :host_configuration,               :foreign_key => :host_configuration_version
    has_many   :host_interface_samples_histories, :foreign_key => :host_interface_configuration_version
  end
end