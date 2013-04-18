module OvirtMetrics
  module NicMetrics
    KILO                = 1024
    MEGA                = 1024 * KILO
    GIGA                = 1024 * MEGA
    GIGABIT_PER_SECOND  = GIGA
    GIGABYTE_PER_SECOND = GIGABIT_PER_SECOND / 8

    def self.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
      count = 0
      sum   = 0
      nic_metrics ||= []
      nic_metrics.each do |n|
        sum   += (n.receive_rate_percent.to_f + n.transmit_rate_percent.to_f) / 2
        count += 1
      end

      return 0.0 if count == 0

      percentage = sum / 100.0
      bytes_per_second = percentage * GIGABYTE_PER_SECOND

      (bytes_per_second / count) / 1024
    end

    def net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
      NicMetrics.net_usage_rate_average_in_kilobytes_per_second(nic_metrics)
    end
  end
end