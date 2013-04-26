require 'active_record'

module OvirtMetrics
  class OvirtHistory < ActiveRecord::Base
    # HACK: The following line is needed so that ActiveRecord 3.2.8 does not try
    #   to dynamically define attribute methods for the OvirtHistory class
    #   itself.  This class does not have a backing table, and is only needed to
    #   allow a shared connection for all subclasses.  If not set, you get the
    #   error "PGError: ERROR:  relation "rhevm_histories" does not exist"
    @attribute_methods_generated = true

    def self.inherited(other)
      super
      other.primary_key = :history_id
      other.table_name  = other.name.split('::').last.underscore
    end

    def self.with_time_range(start_time = nil, end_time = nil)
      return scoped if start_time.nil?
      where(:history_datetime => (start_time..(end_time || Time.now.utc)))
    end

  end
end