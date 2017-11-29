module OvirtMetrics
  COMMON_COLUMN_DEFINITIONS = {
    "cpu_usage_rate_average" => {
      :ovirt_key    => :cpu_usage_rate_average,
      :ovirt_method => lambda { |metrics| metrics[:metric].cpu_usage_percent.to_f },
      :counter      => {
        :counter_key           => "cpu_usage_rate_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "percent",
        :capture_interval_name => "realtime"
      }
    },

    "cpu_usagemhz_rate_average" => {
      :ovirt_key    => :cpu_usagemhz_rate_average,
      :ovirt_method => lambda { |metrics| metrics[:metric].cpu_usagemhz_rate_average },
      :counter      => {
        :counter_key           => "cpu_usagemhz_rate_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "megahertz",
        :capture_interval_name => "realtime"
      }
    },

    "mem_usage_absolute_average" => {
      :ovirt_key    => :mem_usage_absolute_average,
      :ovirt_method => lambda { |metrics| metrics[:metric].memory_usage_percent.to_f },
      :counter      => {
        :counter_key           => "mem_usage_absolute_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "percent",
        :capture_interval_name => "realtime"
      }
    },
  }

  VM_COLUMN_DEFINITIONS = {
    "cpu_usage_rate_average"     => COMMON_COLUMN_DEFINITIONS["cpu_usage_rate_average"],
    "cpu_usagemhz_rate_average"  => COMMON_COLUMN_DEFINITIONS["cpu_usagemhz_rate_average"],
    "mem_usage_absolute_average" => COMMON_COLUMN_DEFINITIONS["mem_usage_absolute_average"],

    "disk_usage_rate_average" => {
      :ovirt_key    => :disk_usage_rate_average,
      :ovirt_method => lambda { |metrics| VmDiskSamplesHistory.disk_usage_rate_average_in_kilobytes_per_second(metrics[:disk]) },
      :counter      => {
        :counter_key           => "disk_usage_rate_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "kilobytespersecond",
        :capture_interval_name => "realtime"
      }
    },

    "net_usage_rate_average" => {
      :ovirt_key    => :net_usage_rate_average,
      :ovirt_method => lambda { |metrics| VmInterfaceSamplesHistory.net_usage_rate_average_in_kilobytes_per_second(metrics[:nic]) },
      :counter      => {
        :counter_key           => "net_usage_rate_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "kilobytespersecond",
        :capture_interval_name => "realtime"
      }
    }
  }

  HOST_COLUMN_DEFINITIONS = {
    "cpu_usage_rate_average"     => COMMON_COLUMN_DEFINITIONS["cpu_usage_rate_average"],
    "cpu_usagemhz_rate_average"  => COMMON_COLUMN_DEFINITIONS["cpu_usagemhz_rate_average"],
    "mem_usage_absolute_average" => COMMON_COLUMN_DEFINITIONS["mem_usage_absolute_average"],

    "net_usage_rate_average" => {
      :ovirt_key    => :net_usage_rate_average,
      :ovirt_method => lambda { |metrics| HostInterfaceSamplesHistory.net_usage_rate_average_in_kilobytes_per_second(metrics[:nic]) },
      :counter      => {
        :counter_key           => "net_usage_rate_average",
        :instance              => "",
        :capture_interval      => "20",
        :precision             => 1,
        :rollup                => "average",
        :unit_key              => "kilobytespersecond",
        :capture_interval_name => "realtime"
      }
    }
  }
end