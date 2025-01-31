require "logger" # Require logger due to active_support breaking on Rails <= 7.0. See https://github.com/rails/rails/pull/54264
require 'active_record'

module ActiveModel::Validations
  # Extension to enhance `should have` on AR Model instances.  Calls
  # model.valid? in order to prepare the object's errors object.
  #
  # You can also use this to specify the content of the error messages.
  #
  # @example
  #
  #     model.should have(:no).errors_on(:attribute)
  #     model.should have(1).error_on(:attribute)
  #     model.should have(n).errors_on(:attribute)
  #
  #     model.errors_on(:attribute).should include("can't be blank")
  def errors_on(attribute)
    self.valid?
    [self.errors[attribute]].flatten.compact
  end
  alias :error_on :errors_on
end

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

def load_rhev_31
  ActiveRecord::Schema.verbose = false
  load File.join(File.dirname(__FILE__), %w{.. schemas schema_rhev31.rb})
  reset_models
end

def load_rhev_40
  ActiveRecord::Schema.verbose = false
  load File.join(File.dirname(__FILE__), %w{.. schemas schema_rhev40.rb})
  reset_models
end

def reset_models
  OvirtMetrics.constants.each do |c|
    o = OvirtMetrics.const_get(c)
    next if o == OvirtMetrics::OvirtHistory
    next unless o.respond_to?(:ancestors) && o.ancestors.include?(ActiveRecord::Base)
    o.reset_column_information
  end
end
