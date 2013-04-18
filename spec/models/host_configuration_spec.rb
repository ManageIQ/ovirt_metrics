require File.expand_path(File.join(File.dirname(__FILE__), %w{.. spec_helper}))

require 'ovirt_metrics'

describe OvirtMetrics::HostConfiguration do
  shared_examples_for "HostConfiguration" do
    context "#speed_in_mhz" do
      it "when cpu_model is nil" do
        described_class.new(:cpu_model => nil).speed_in_mhz.should be_nil
      end

      it "when cpu_model is in GHz" do
        described_class.new(:cpu_model => "Intel(R) Xeon(R) CPU E5506 @ 2.00GHz").speed_in_mhz.should == 2048.0
      end

      it "when cpu_model is in MHz" do
        described_class.new(:cpu_model => "Intel(R) Xeon(R) CPU E5506 @ 2.00MHz").speed_in_mhz.should == 2.0
      end

      it "when cpu_model is some other string" do
        described_class.new(:cpu_model => "XXX").speed_in_mhz.should be_nil
      end
    end
  end

  context "RHEV 3.0" do
    before(:each) { load_rhev_30 }
    it_should_behave_like "HostConfiguration"
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "HostConfiguration"
  end
end