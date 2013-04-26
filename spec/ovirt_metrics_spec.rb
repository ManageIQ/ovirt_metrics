require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

require 'ovirt_metrics'

describe OvirtMetrics do
  shared_examples_for "OvirtMetrics" do
    context ".vm_realtime" do
      it "when vm_id finds no matches" do
        described_class.vm_realtime(42).should == [{}, {}]
      end

      it "when vm_id finds 1 match" do
        assert_object_with_empty_samples_data("vm")
      end
    end

    context ".host_realtime" do
      it "when host_id finds no matches" do
        described_class.host_realtime(42).should == [{}, {}]
      end

      it "when host_id finds 1 match" do
        assert_object_with_empty_samples_data("host")
      end
    end

    def assert_object_with_empty_samples_data(type)
      id = 42
      status = 1
      history_datetime = Time.now
      klass = "OvirtMetrics::#{type.capitalize}SamplesHistory".constantize
      id_key     = "#{type}_id".to_sym
      status_key = "#{type}_status".to_sym
      record_attrs = {
                  id_key            => id,
                  status_key        => status,
                  :history_datetime => history_datetime,
      }
      record = klass.create!(record_attrs)

      href = "/api/#{type.pluralize}/#{id}"
      constant = "OvirtMetrics::#{type.upcase}_COLUMN_DEFINITIONS".constantize
      column_definitions = constant.each_with_object({}) do |defn, hash|
        name, defn = defn
        key   = defn[:ovirt_key]
        value = defn[:counter]
        hash[key] = value
      end
      columns = { href => column_definitions }

      rows_hash = {}
      row_value = [0, 20, 40].each_with_object({}) do |offset, hash|
        key = (record.history_datetime + offset).utc.iso8601.to_s
        value = column_definitions.keys.each_with_object({}) { |key, col_hash| col_hash[key] = 0.0 }
        rows_hash[key] = value
      end
      rows = { href => rows_hash }

      method = "#{type}_realtime"
      described_class.send(method, id).should == [columns, rows]
    end

  end

  context "RHEV 3.0" do
    before(:each) { load_rhev_30 }
    it_should_behave_like "OvirtMetrics"
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "OvirtMetrics"
  end

end