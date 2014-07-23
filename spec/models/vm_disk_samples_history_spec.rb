describe OvirtMetrics::VmDiskSamplesHistory do
  KILOBYTE = 1024
  MEGABYTE = KILOBYTE * 1024

  shared_examples_for "VmDiskSamplesHistory" do
    context ".disk_usage_rate_average_in_kilobytes_per_second" do
      it "when disk_metrics array is empty" do
        expect(described_class.disk_usage_rate_average_in_kilobytes_per_second([])).to eq(0.0)
      end

      it "when disk_metrics array has one element" do
        disk_metric = double("disk_metric")
        allow(disk_metric).to receive_messages(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 1.0 * MEGABYTE)
        expected_result = (disk_metric.read_rate_bytes_per_second + disk_metric.write_rate_bytes_per_second) / KILOBYTE
        expect(described_class.disk_usage_rate_average_in_kilobytes_per_second([disk_metric])).to eq(expected_result)
      end

      it "when disk_metrics array has two elements" do
        disk_metric1 = double("disk_metric")
        allow(disk_metric1).to receive_messages(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 1.0 * MEGABYTE)

        disk_metric2 = double("disk_metric")
        allow(disk_metric2).to receive_messages(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 5.0 * MEGABYTE)

        sum_m1 = disk_metric1.read_rate_bytes_per_second + disk_metric1.write_rate_bytes_per_second
        sum_m2 = disk_metric2.read_rate_bytes_per_second + disk_metric2.write_rate_bytes_per_second
        expected_result = (sum_m1 + sum_m2) / KILOBYTE / 2
        expect(described_class.disk_usage_rate_average_in_kilobytes_per_second([disk_metric1, disk_metric2])).to eq(expected_result)
      end
    end
  end

  context "RHEV 3.0" do
    before(:each) { load_rhev_30 }
    it_should_behave_like "VmDiskSamplesHistory"
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "VmDiskSamplesHistory"
  end
end
