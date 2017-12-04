module OvirtMetrics
  class VmSamplesHistory < OvirtHistory
    belongs_to :host_configuration, :foreign_key => :current_host_configuration_version
    belongs_to :vm_configuration,   :foreign_key => :vm_configuration_version

    def cpu_usagemhz_rate_average
      speed_of_host = self.host_configuration.try(:cpu_speed_mh).to_f

      # TODO: Research if self.host_configuration.speed_in_mhz is aggregate or per core/socket
      # enumerator    = self.vm_configuration.cpu_per_socket * self.vm_configuration.number_of_sockets
      # vm_allocation = enumerator.to_f / self.host_configuration.number_of_cores
      # speed_of_vm   = vm_allocation * self.host_configuration.speed_in_mhz

      speed_of_host * (self.cpu_usage_percent.to_f / 100.0)
    end
  end
end
