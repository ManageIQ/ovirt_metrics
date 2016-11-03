module OvirtMetrics
  class Configurator
    def initialize
      self.suppress_warnings = false
      self.connection_specification_name = 'ovirt_metrics' if ActiveRecord::VERSION::MAJOR >= 5
    end

    attr_accessor :suppress_warnings

    attr_reader :connection_specification_name

    def connection_specification_name=(value)
      if ActiveRecord::VERSION::MAJOR < 5
        OvirtMetrics.warn "WARNING: ovirt_metric's " \
          "connection_specification_name option is only available with " \
          "Active Record 5 or newer. The main application pool " \
          "('primary') will be used by default until you connect to a " \
          "separate Ovirt database."
      else
        @connection_specification_name = value
      end
    end
  end
end
