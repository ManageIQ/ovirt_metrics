describe OvirtMetrics::VmSamplesHistory do
  shared_examples_for "VmSamplesHistory" do
    context "#cpu_usagemhz_rate_average" do
      it "when host_configuration is nil" do
        vm_history = described_class.new
        allow(vm_history).to receive_messages(:host_configuration => nil)

        expect(vm_history.cpu_usagemhz_rate_average).to eq(0)
      end

      context "when host_configuration exists" do
        it "and cpu_speed_mh is nil" do
          vm_history = described_class.new(:host_configuration => OvirtMetrics::HostConfiguration.new)
          expect(vm_history.cpu_usagemhz_rate_average).to eq(0)
        end

        it "and cpu_speed_mh is not nil" do
          host_configuration = OvirtMetrics::HostConfiguration.new
          allow(host_configuration).to receive_messages(:cpu_speed_mh => 2048.0)

          vm_history = described_class.new(
            :cpu_usage_percent  => 50,
            :host_configuration => host_configuration
          )
          expect(vm_history.cpu_usagemhz_rate_average).to eq(1024.0)
        end
      end
    end
  end

  context "RHEV 3.1" do
    before(:each) { load_rhev_31 }
    it_should_behave_like "VmSamplesHistory"
  end
end
