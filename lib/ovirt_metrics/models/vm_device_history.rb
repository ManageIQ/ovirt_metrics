module OvirtMetrics
  class VmDeviceHistory < OvirtHistory
    # have to rename the inheritance_column since this table has a column
    # called "type"
    self.inheritance_column = :_type_disabled

    scope :disks,    -> { where(:type => "disk") }
    scope :nics,     -> { where(:type => "interface") }
    scope :attached, -> { where(:delete_date => nil) }
  end
end
