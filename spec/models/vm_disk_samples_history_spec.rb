require File.expand_path(File.join(File.dirname(__FILE__), %w{.. spec_helper}))

require 'ovirt_metrics'

describe OvirtMetrics::VmDiskSamplesHistory do
  KILOBYTE = 1024
  MEGABYTE = KILOBYTE * 1024

  shared_examples_for "VmDiskSamplesHistory" do
    context ".disk_usage_rate_average_in_kilobytes_per_second" do
      it "when disk_metrics array is empty" do
        described_class.disk_usage_rate_average_in_kilobytes_per_second([]).should == 0.0
      end

      it "when disk_metrics array has one element" do
        disk_metric = double("disk_metric")
        disk_metric.stub(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 1.0 * MEGABYTE)
        expected_result = (disk_metric.read_rate_bytes_per_second + disk_metric.write_rate_bytes_per_second) / KILOBYTE
        described_class.disk_usage_rate_average_in_kilobytes_per_second([disk_metric]).should == expected_result
      end

      it "when disk_metrics array has two elements" do
        disk_metric1 = double("disk_metric")
        disk_metric1.stub(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 1.0 * MEGABYTE)

        disk_metric2 = double("disk_metric")
        disk_metric2.stub(:read_rate_bytes_per_second => 2.0 * MEGABYTE, :write_rate_bytes_per_second => 5.0 * MEGABYTE)

        sum_m1 = disk_metric1.read_rate_bytes_per_second + disk_metric1.write_rate_bytes_per_second
        sum_m2 = disk_metric2.read_rate_bytes_per_second + disk_metric2.write_rate_bytes_per_second
        expected_result = (sum_m1 + sum_m2) / KILOBYTE / 2
        described_class.disk_usage_rate_average_in_kilobytes_per_second([disk_metric1, disk_metric2]).should == expected_result
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