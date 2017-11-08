module OvirtMetrics
  class HostSamplesHistory < OvirtHistory
    belongs_to :host_configuration, :foreign_key => :host_configuration_version

    def cpu_usagemhz_rate_average
      return 0.0 if self.host_configuration.nil?
      speed_of_host = self.host_configuration.cpu_speed_mh.to_f * self.host_configuration.number_of_cores.to_i
      return (speed_of_host * (self.cpu_usage_percent.to_f / 100.0))
    end
  end
end