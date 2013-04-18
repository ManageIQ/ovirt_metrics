require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

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

def load_rhev_30
  ActiveRecord::Schema.verbose = false
  load File.join(File.dirname(__FILE__), %w{.. schemas schema_rhev30.rb})
end

def load_rhev_31
  ActiveRecord::Schema.verbose = false
  load File.join(File.dirname(__FILE__), %w{.. schemas schema_rhev31.rb})
end