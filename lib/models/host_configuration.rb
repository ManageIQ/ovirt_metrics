module OvirtMetrics
  class HostConfiguration < OvirtHistory
    has_many :host_interface_configurations, :foreign_key => :host_configuration_version

    belongs_to :cluster_configuration, :foreign_key => :cluster_configuration_version

    GHZ_REGEX = /.*\@\s*(\d+\.\d+)GHz/
    MHZ_REGEX = /.*\@\s*(\d+\.\d+)MHz/
    def speed_in_mhz
      if self.cpu_model.respond_to?(:match)
        match = self.cpu_model.match(GHZ_REGEX)
        return (match[1].to_f * 1024) if match

        match = self.cpu_model.match(MHZ_REGEX)
        return match[1].to_f if match
      end

      return nil
    end
  end
end