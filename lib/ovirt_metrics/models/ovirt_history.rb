module OvirtMetrics
  class OvirtHistory < ActiveRecord::Base
    self.abstract_class = true
    self.pluralize_table_names = false

    def self.with_time_range(start_time = nil, end_time = nil)
      return all if start_time.nil?
      where(:history_datetime => (start_time..(end_time || Time.now.utc)))
    end

  end
end
