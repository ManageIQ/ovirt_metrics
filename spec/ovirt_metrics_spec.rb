describe OvirtMetrics do
  shared_examples_for "OvirtMetrics" do |multiplication_required|
    let(:multiplication_required) { multiplication_required }
    describe ".vms_disk_ids_for" do
      before(:each) do
        @vm1_id = 1
        @device_id1 = "device1"
        @device_id2 = "device2"
        generic_params = {
          :vm_id       => @vm1_id,
          :device_id   => @device_id1,
          :type        => "disk",
          :address     => "address",
          :create_date => 1.week.ago
        }
        OvirtMetrics::VmDeviceHistory.create(generic_params)
        OvirtMetrics::VmDeviceHistory.create(generic_params.merge(:address => "duplicate_with_same_device_id"))
        OvirtMetrics::VmDeviceHistory.create(generic_params.merge(:device_id => @device_id2))
        OvirtMetrics::VmDeviceHistory.create(generic_params.merge(:vm_id => 2, :device_id => "disk_from_other_vm"))
        OvirtMetrics::VmDeviceHistory.create(generic_params.merge(:type      => "nic",
                                                                  :device_id => "device_of_non_disk_type"))
        OvirtMetrics::VmDeviceHistory.create(generic_params.merge(:device_id   => "device_that_was_deleted",
                                                                  :delete_date => 2.days.ago))
      end

      subject { described_class.vms_disk_ids_for(@vm1_id) }

      it { is_expected.to match_array([@device_id1, @device_id2]) }
      it { is_expected.not_to include("disk_from_other_vm") }
      it { is_expected.not_to include("device_of_non_disk_type") }
      it { is_expected.not_to include("device_that_was_deleted") }
    end

    context ".vm_realtime" do
      it "when vm_id finds no matches" do
        expect(described_class.vm_realtime(42)).to eq([{}, {}])
      end

      it "when vm_id finds 1 match" do
        assert_object_with_empty_samples_data("vm")
      end
    end

    context ".host_realtime" do
      it "when host_id finds no matches" do
        expect(described_class.host_realtime(42)).to eq([{}, {}])
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
      column_definitions = constant.each_with_object({}) do |(_name, defn), hash|
        key   = defn[:ovirt_key]
        value = defn[:counter]
        hash[key] = value
      end
      columns = { href => column_definitions }

      offsets = multiplication_required ? [0, 20, 40] : [0]

      rows_hash = offsets.each_with_object({}) do |offset, hash|
        value = column_definitions.keys.each_with_object({}) { |key, col_hash| col_hash[key] = 0.0 }
        key   = (record.history_datetime + offset).utc.iso8601.to_s
        hash[key] = value
      end
      rows = { href => rows_hash }
      method = "#{type}_realtime"
      expect(described_class.send(method, id)).to eq([columns, rows])
    end

  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "OvirtMetrics", true
  end

  context "RHEV 4" do
    before(:each) { load_rhev_40 }
    it_should_behave_like "OvirtMetrics", false
  end

end
