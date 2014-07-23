require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

require 'ovirt_metrics'

describe OvirtMetrics::NicMetrics do
  context ".net_usage_rate_average_in_kilobytes_per_second" do
    it "when nic_metrics array is empty" do
      expect(described_class.net_usage_rate_average_in_kilobytes_per_second([])).to eq(0.0)
    end

    it "when nic_metrics array has one element" do
      nic_metric = double("nic_metric")
      allow(nic_metric).to receive_messages(:receive_rate_percent => 90, :transmit_rate_percent => 10)
      expected = (OvirtMetrics::NicMetrics::GIGABYTE_PER_SECOND / 2) / 1024
      expect(described_class.net_usage_rate_average_in_kilobytes_per_second([nic_metric])).to eq(expected)
    end

    it "when nic_metrics array has multiple elements" do
      nic_metric1 = double("nic_metric")
      allow(nic_metric1).to receive_messages(:receive_rate_percent => 90, :transmit_rate_percent => 10)
      nic_metric2 = double("nic_metric")
      allow(nic_metric2).to receive_messages(:receive_rate_percent => 90, :transmit_rate_percent => 10)
      expected = (OvirtMetrics::NicMetrics::GIGABYTE_PER_SECOND / 2) / 1024
      expect(described_class.net_usage_rate_average_in_kilobytes_per_second([nic_metric1, nic_metric2])).to eq(expected)
    end
  end
end