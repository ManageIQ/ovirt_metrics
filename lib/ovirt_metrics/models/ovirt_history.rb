module OvirtMetrics
  class OvirtHistory < ActiveRecord::Base
    attr_writer :connection_specification_name if ActiveRecord::VERSION::MAJOR < 5

    self.abstract_class = true
    self.pluralize_table_names = false

    def self.connection_specification_name
      if !defined?(@connection_specification_name) || @connection_specification_name.nil?
        return self == OvirtHistory ? OvirtMetrics.config.connection_specification_name : superclass.connection_specification_name
      end
      @connection_specification_name
    end

    def self.with_time_range(start_time = nil, end_time = nil)
      return all if start_time.nil?
      where(:history_datetime => (start_time..(end_time || Time.now.utc)))
    end

  end
end
