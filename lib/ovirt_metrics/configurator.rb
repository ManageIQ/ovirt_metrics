module OvirtMetrics
  class Configurator
    def initialize
      self.suppress_warnings = false
      self.connection_specification_name = 'ovirt_metrics' if ActiveRecord::VERSION::MAJOR >= 5
    end

    attr_accessor :suppress_warnings

    attr_reader :connection_specification_name

    def connection_specification_name=(value)
      @connection_specification_name = value
    end
  end
end
