require File.expand_path(File.join(File.dirname(__FILE__), %w{.. spec_helper}))

require 'ovirt_metrics'

describe OvirtMetrics::VmInterfaceSamplesHistory do
  shared_examples_for "VmInterfaceSamplesHistory" do
    context ".net_usage_rate_average_in_kilobytes_per_second" do
      it "when nic_metrics array is empty" do
        described_class.net_usage_rate_average_in_kilobytes_per_second([]).should == 0.0
      end

      it "when nic_metrics array has one element with 90% receiving and 10% transmitting" do
        nic_metric = double("nic_metric")
        nic_metric.stub(:receive_rate_percent => 90, :transmit_rate_percent => 10)
        described_class.net_usage_rate_average_in_kilobytes_per_second([nic_metric]).should == (OvirtMetrics::NicMetrics::GIGABYTE_PER_SECOND / 2) / 1024
      end

      it "when nic_metrics array has two elements with 90% receiving and 10% transmitting each" do
        nic_metric1 = double("nic_metric")
        nic_metric1.stub(:receive_rate_percent => 90, :transmit_rate_percent => 10)
        nic_metric2 = double("nic_metric")
        nic_metric2.stub(:receive_rate_percent => 90, :transmit_rate_percent => 10)
        described_class.net_usage_rate_average_in_kilobytes_per_second([nic_metric1, nic_metric2]).should == (OvirtMetrics::NicMetrics::GIGABYTE_PER_SECOND / 2) / 1024
      end
    end
  end

  context "RHEV 3.0" do
    before(:each) { load_rhev_30 }
    it_should_behave_like "VmInterfaceSamplesHistory"
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "VmInterfaceSamplesHistory"
  end
end