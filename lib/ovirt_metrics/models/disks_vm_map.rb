module OvirtMetrics
  class DisksVmMap < OvirtHistory
    has_many :vm_disk_samples_histories, :foreign_key => :vm_disk_id, :primary_key => :vm_disk_id
  end
end