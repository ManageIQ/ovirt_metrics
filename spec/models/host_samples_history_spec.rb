require File.expand_path(File.join(File.dirname(__FILE__), %w{.. spec_helper}))

require 'ovirt_metrics'

describe OvirtMetrics::HostSamplesHistory do
  shared_examples_for "HostSamplesHistory" do
    context "#cpu_usagemhz_rate_average" do
      before(:each) { @host_configuration = OvirtMetrics::HostConfiguration.new }
      context "when host_configuration exists" do
        it "and speed_in_mhz and number_of_cores is nil" do
          host_history = described_class.new(:host_configuration => @host_configuration)
          host_history.cpu_usagemhz_rate_average.should == 0
        end

        it "and speed_in_mhz is nil and number_of_cores is numeric" do
          host_history = described_class.new(:host_configuration => @host_configuration)
          @host_configuration.stub(:number_of_cores => 1)
          host_history.cpu_usagemhz_rate_average.should == 0
        end

        it "and speed_in_mhz is numeric and number_of_cores is nil" do
          host_history = described_class.new(:host_configuration => @host_configuration)
          @host_configuration.stub(:speed_in_mhz => 2048.0)
          host_history.cpu_usagemhz_rate_average.should == 0
        end

        it "and speed_in_mhz is numeric and number_of_cores is numeric" do
          host_configuration = OvirtMetrics::HostConfiguration.new
          @host_configuration.stub(:speed_in_mhz => 2048.0)
          @host_configuration.stub(:number_of_cores => 2)

          host_history = described_class.new(
            :cpu_usage_percent  => 50,
            :host_configuration => @host_configuration
          )
          host_history.cpu_usagemhz_rate_average.should == 2048.0
        end
      end
    end
  end

  context "RHEV 3.0" do
    before(:each) { load_rhev_30 }
    it_should_behave_like "HostSamplesHistory"
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "HostSamplesHistory"
  end
end