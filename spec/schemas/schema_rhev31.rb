# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130115171747) do

  create_table "calendar", :id => false, :force => true do |t|
    t.datetime "the_datetime",              :null => false
    t.date     "the_date",                  :null => false
    t.integer  "the_year",     :limit => 2, :null => false
    t.integer  "the_month",    :limit => 2, :null => false
    t.string   "month_name",   :limit => 9, :null => false
    t.integer  "the_day",      :limit => 2, :null => false
    t.string   "day_name",     :limit => 9, :null => false
    t.time     "the_hour",                  :null => false
  end

  add_index "calendar", ["the_date"], :name => "calendar_table_index"

  create_table "cluster_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "cluster_id",                       :limit => nil,                     :null => false
    t.string   "cluster_name",                     :limit => 40,                      :null => false
    t.string   "cluster_description",              :limit => 4000
    t.string   "datacenter_id",                    :limit => nil
    t.string   "cpu_name"
    t.string   "compatibility_version",            :limit => 40,   :default => "2.2", :null => false
    t.integer  "datacenter_configuration_version"
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "cluster_configuration", ["cluster_id"], :name => "cluster_configuration_cluster_id_idx"
  add_index "cluster_configuration", ["datacenter_id"], :name => "cluster_configuration_datacenter_id_idx"

  create_table "datacenter_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "datacenter_id",          :limit => nil,  :null => false
    t.string   "datacenter_name",        :limit => 40,   :null => false
    t.string   "datacenter_description", :limit => 4000, :null => false
    t.integer  "storage_type",           :limit => 2,    :null => false
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "datacenter_configuration", ["datacenter_id"], :name => "datacenter_configuration_datacenter_id_idx"

  create_table "datacenter_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                                                               :null => false
    t.string  "datacenter_id",                    :limit => nil,                                                :null => false
    t.integer "datacenter_status",                :limit => 2,                                                  :null => false
    t.decimal "minutes_in_status",                               :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer "datacenter_configuration_version",                                                               :null => false
  end

  add_index "datacenter_daily_history", ["datacenter_configuration_version"], :name => "idx_datacenter_configuration_version_daily"
  add_index "datacenter_daily_history", ["datacenter_id"], :name => "datacenter_daily_history_datacenter_id_idx"
  add_index "datacenter_daily_history", ["history_datetime"], :name => "idx_datacenter_history_datetime_daily"

  create_table "datacenter_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                               :null => false
    t.string   "datacenter_id",                    :limit => nil,                                                :null => false
    t.integer  "datacenter_status",                :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                               :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "datacenter_configuration_version",                                                               :null => false
  end

  add_index "datacenter_hourly_history", ["datacenter_configuration_version"], :name => "idx_datacenter_configuration_version_hourly"
  add_index "datacenter_hourly_history", ["datacenter_id"], :name => "datacenter_hourly_history_datacenter_id_idx"
  add_index "datacenter_hourly_history", ["history_datetime"], :name => "idx_datacenter_history_datetime_hourly"

  create_table "datacenter_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                               :null => false
    t.string   "datacenter_id",                    :limit => nil,                                                :null => false
    t.integer  "datacenter_status",                :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                               :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "datacenter_configuration_version",                                                               :null => false
  end

  add_index "datacenter_samples_history", ["datacenter_configuration_version"], :name => "idx_datacenter_configuration_version_samples"
  add_index "datacenter_samples_history", ["datacenter_id"], :name => "datacenter_samples_history_datacenter_id_idx"
  add_index "datacenter_samples_history", ["history_datetime"], :name => "idx_datacenter_history_datetime_samples"

  create_table "datacenter_storage_domain_map", :primary_key => "history_id", :force => true do |t|
    t.string   "storage_domain_id", :limit => nil, :null => false
    t.string   "datacenter_id",     :limit => nil, :null => false
    t.datetime "attach_date",                      :null => false
    t.datetime "detach_date"
  end

  add_index "datacenter_storage_domain_map", ["datacenter_id"], :name => "datacenter_storage_domain_map_datacenter_id_idx"
  add_index "datacenter_storage_domain_map", ["storage_domain_id"], :name => "datacenter_storage_domain_map_storage_domain_id_idx"

  create_table "disks_vm_map", :primary_key => "history_id", :force => true do |t|
    t.string   "vm_disk_id",  :limit => nil, :null => false
    t.string   "vm_id",       :limit => nil, :null => false
    t.datetime "attach_date",                :null => false
    t.datetime "detach_date"
  end

  add_index "disks_vm_map", ["vm_disk_id"], :name => "disks_vm_map_vm_disk_id_idx"
  add_index "disks_vm_map", ["vm_id"], :name => "disks_vm_map_vm_id_idx"

  create_table "enum_translator", :id => false, :force => true do |t|
    t.string  "enum_type",     :limit => 40, :null => false
    t.integer "enum_key",      :limit => 2,  :null => false
    t.string  "language_code", :limit => 40, :null => false
    t.text    "value",                       :null => false
  end

  create_table "history_configuration", :id => false, :force => true do |t|
    t.string   "var_name",     :limit => 50, :null => false
    t.string   "var_value"
    t.datetime "var_datetime"
  end

  create_table "host_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "host_id",                       :limit => nil,                                               :null => false
    t.string   "host_unique_id",                :limit => 128
    t.string   "host_name",                                                                                  :null => false
    t.string   "cluster_id",                    :limit => nil,                                               :null => false
    t.integer  "host_type",                     :limit => 2,                                  :default => 0, :null => false
    t.string   "fqdn_or_ip",                                                                                 :null => false
    t.integer  "memory_size_mb"
    t.integer  "swap_size_mb"
    t.string   "cpu_model"
    t.integer  "number_of_cores",               :limit => 2
    t.string   "host_os"
    t.string   "pm_ip_address"
    t.string   "kernel_version"
    t.string   "kvm_version"
    t.string   "vdsm_version",                  :limit => 40
    t.integer  "vdsm_port",                                                                                  :null => false
    t.integer  "cluster_configuration_version"
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
    t.integer  "number_of_sockets",             :limit => 2
    t.decimal  "cpu_speed_mh",                                 :precision => 18, :scale => 0
  end

  add_index "host_configuration", ["cluster_id"], :name => "host_configuration_cluster_id_idx"
  add_index "host_configuration", ["host_id"], :name => "host_configuration_host_id_idx"

  create_table "host_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                                                           :null => false
    t.string  "host_id",                      :limit => nil,                                                :null => false
    t.integer "host_status",                  :limit => 2,                                                  :null => false
    t.decimal "minutes_in_status",                           :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer "memory_usage_percent",         :limit => 2,                                 :default => 0
    t.integer "max_memory_usage",             :limit => 2
    t.integer "cpu_usage_percent",            :limit => 2
    t.integer "max_cpu_usage",                :limit => 2
    t.integer "ksm_cpu_percent",              :limit => 2,                                 :default => 0
    t.integer "max_ksm_cpu_percent",          :limit => 2,                                 :default => 0
    t.integer "active_vms",                   :limit => 2,                                 :default => 0
    t.integer "max_active_vms",               :limit => 2,                                 :default => 0
    t.integer "total_vms",                    :limit => 2,                                 :default => 0
    t.integer "max_total_vms",                :limit => 2,                                 :default => 0
    t.integer "total_vms_vcpus",                                                           :default => 0
    t.integer "max_total_vms_vcpus",                                                       :default => 0
    t.integer "cpu_load",                                                                  :default => 0
    t.integer "max_cpu_load",                                                              :default => 0
    t.integer "system_cpu_usage_percent",     :limit => 2,                                 :default => 0
    t.integer "max_system_cpu_usage_percent", :limit => 2,                                 :default => 0
    t.integer "user_cpu_usage_percent",       :limit => 2,                                 :default => 0
    t.integer "max_user_cpu_usage_percent",   :limit => 2,                                 :default => 0
    t.integer "swap_used_mb"
    t.integer "max_swap_used_mb"
    t.integer "host_configuration_version"
  end

  add_index "host_daily_history", ["history_datetime"], :name => "idx_host_history_datetime_daily"
  add_index "host_daily_history", ["host_configuration_version"], :name => "idx_host_configuration_version_daily"
  add_index "host_daily_history", ["host_id"], :name => "host_daily_history_host_id_idx"

  create_table "host_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                           :null => false
    t.string   "host_id",                      :limit => nil,                                                :null => false
    t.integer  "host_status",                  :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                           :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "memory_usage_percent",         :limit => 2,                                 :default => 0
    t.integer  "max_memory_usage",             :limit => 2
    t.integer  "cpu_usage_percent",            :limit => 2
    t.integer  "max_cpu_usage",                :limit => 2
    t.integer  "ksm_cpu_percent",              :limit => 2,                                 :default => 0
    t.integer  "max_ksm_cpu_percent",          :limit => 2,                                 :default => 0
    t.integer  "active_vms",                   :limit => 2,                                 :default => 0
    t.integer  "max_active_vms",               :limit => 2,                                 :default => 0
    t.integer  "total_vms",                    :limit => 2,                                 :default => 0
    t.integer  "max_total_vms",                :limit => 2,                                 :default => 0
    t.integer  "total_vms_vcpus",                                                           :default => 0
    t.integer  "max_total_vms_vcpus",                                                       :default => 0
    t.integer  "cpu_load",                                                                  :default => 0
    t.integer  "max_cpu_load",                                                              :default => 0
    t.integer  "system_cpu_usage_percent",     :limit => 2,                                 :default => 0
    t.integer  "max_system_cpu_usage_percent", :limit => 2,                                 :default => 0
    t.integer  "user_cpu_usage_percent",       :limit => 2,                                 :default => 0
    t.integer  "max_user_cpu_usage_percent",   :limit => 2,                                 :default => 0
    t.integer  "swap_used_mb"
    t.integer  "max_swap_used_mb"
    t.integer  "host_configuration_version"
  end

  add_index "host_hourly_history", ["history_datetime"], :name => "idx_host_history_datetime_hourly"
  add_index "host_hourly_history", ["host_configuration_version"], :name => "idx_host_configuration_version_hourly"
  add_index "host_hourly_history", ["host_id"], :name => "host_hourly_history_host_id_idx"

  create_table "host_interface_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "host_interface_id",          :limit => nil, :null => false
    t.string   "host_interface_name",        :limit => 50,  :null => false
    t.string   "host_id",                    :limit => nil, :null => false
    t.integer  "host_interface_type",        :limit => 2
    t.integer  "host_interface_speed_bps"
    t.string   "mac_address",                :limit => 59
    t.string   "network_name",               :limit => 50
    t.string   "ip_address",                 :limit => 20
    t.string   "gateway",                    :limit => 20
    t.boolean  "bond"
    t.string   "bond_name",                  :limit => 50
    t.integer  "vlan_id"
    t.integer  "host_configuration_version"
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "host_interface_configuration", ["host_id"], :name => "host_interface_configuration_host_id_idx"
  add_index "host_interface_configuration", ["host_interface_id"], :name => "host_interface_configuration_host_interface_id_idx"

  create_table "host_interface_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                    :null => false
    t.string  "host_interface_id",                    :limit => nil, :null => false
    t.integer "receive_rate_percent",                 :limit => 2
    t.integer "max_receive_rate_percent",             :limit => 2
    t.integer "transmit_rate_percent",                :limit => 2
    t.integer "max_transmit_rate_percent",            :limit => 2
    t.integer "host_interface_configuration_version"
  end

  add_index "host_interface_daily_history", ["history_datetime"], :name => "idx_host_interface_history_datetime_daily"
  add_index "host_interface_daily_history", ["host_interface_configuration_version"], :name => "idx_host_interface_configuration_version_daily"
  add_index "host_interface_daily_history", ["host_interface_id"], :name => "host_interface_daily_history_host_interface_id_idx"

  create_table "host_interface_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                    :null => false
    t.string   "host_interface_id",                    :limit => nil, :null => false
    t.integer  "receive_rate_percent",                 :limit => 2
    t.integer  "max_receive_rate_percent",             :limit => 2
    t.integer  "transmit_rate_percent",                :limit => 2
    t.integer  "max_transmit_rate_percent",            :limit => 2
    t.integer  "host_interface_configuration_version"
  end

  add_index "host_interface_hourly_history", ["history_datetime"], :name => "idx_host_interface_history_datetime_hourly"
  add_index "host_interface_hourly_history", ["host_interface_configuration_version"], :name => "idx_host_interface_configuration_version_hourly"
  add_index "host_interface_hourly_history", ["host_interface_id"], :name => "host_interface_hourly_history_host_interface_id_idx"

  create_table "host_interface_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                    :null => false
    t.string   "host_interface_id",                    :limit => nil, :null => false
    t.integer  "receive_rate_percent",                 :limit => 2
    t.integer  "transmit_rate_percent",                :limit => 2
    t.integer  "host_interface_configuration_version"
  end

  add_index "host_interface_samples_history", ["history_datetime"], :name => "idx_host_interface_history_datetime_samples"
  add_index "host_interface_samples_history", ["host_interface_configuration_version"], :name => "idx_host_interface_configuration_version_samples"
  add_index "host_interface_samples_history", ["host_interface_id"], :name => "host_interface_samples_history_host_interface_id_idx"

  create_table "host_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                         :null => false
    t.string   "host_id",                    :limit => nil,                                                :null => false
    t.integer  "host_status",                :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                         :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "memory_usage_percent",       :limit => 2,                                 :default => 0
    t.integer  "cpu_usage_percent",          :limit => 2
    t.integer  "ksm_cpu_percent",            :limit => 2,                                 :default => 0
    t.integer  "active_vms",                 :limit => 2,                                 :default => 0
    t.integer  "total_vms",                  :limit => 2,                                 :default => 0
    t.integer  "total_vms_vcpus",                                                         :default => 0
    t.integer  "cpu_load",                                                                :default => 0
    t.integer  "system_cpu_usage_percent",   :limit => 2,                                 :default => 0
    t.integer  "user_cpu_usage_percent",     :limit => 2,                                 :default => 0
    t.integer  "swap_used_mb"
    t.integer  "host_configuration_version"
  end

  add_index "host_samples_history", ["history_datetime"], :name => "idx_host_history_datetime_samples"
  add_index "host_samples_history", ["host_configuration_version"], :name => "idx_host_configuration_version_samples"
  add_index "host_samples_history", ["host_id"], :name => "host_samples_history_host_id_idx"

  create_table "schema_version", :force => true do |t|
    t.string   "version",      :limit => 10,                  :null => false
    t.string   "script",                                      :null => false
    t.string   "checksum",     :limit => 128
    t.string   "installed_by", :limit => 30,                  :null => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "state",        :limit => 15,                  :null => false
    t.boolean  "current",                                     :null => false
    t.text     "comment",                     :default => ""
  end

  create_table "storage_domain_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "storage_domain_id",   :limit => nil, :null => false
    t.string   "storage_domain_name", :limit => 250, :null => false
    t.integer  "storage_domain_type", :limit => 2,   :null => false
    t.integer  "storage_type",        :limit => 2,   :null => false
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "storage_domain_configuration", ["storage_domain_id"], :name => "storage_domain_configuration_storage_domain_id_idx"

  create_table "storage_domain_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                             :null => false
    t.string  "storage_domain_id",             :limit => nil, :null => false
    t.integer "available_disk_size_gb"
    t.integer "used_disk_size_gb"
    t.integer "storage_configuration_version"
  end

  add_index "storage_domain_daily_history", ["history_datetime"], :name => "idx_storage_domain_history_datetime_daily"
  add_index "storage_domain_daily_history", ["storage_configuration_version"], :name => "idx_storage_configuration_version_daily"
  add_index "storage_domain_daily_history", ["storage_domain_id"], :name => "storage_domain_daily_history_storage_domain_id_idx"

  create_table "storage_domain_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                             :null => false
    t.string   "storage_domain_id",             :limit => nil, :null => false
    t.integer  "available_disk_size_gb"
    t.integer  "used_disk_size_gb"
    t.integer  "storage_configuration_version"
  end

  add_index "storage_domain_hourly_history", ["history_datetime"], :name => "idx_storage_history_datetime_hourly"
  add_index "storage_domain_hourly_history", ["storage_configuration_version"], :name => "idx_storage_configuration_version_hourly"
  add_index "storage_domain_hourly_history", ["storage_domain_id"], :name => "storage_domain_hourly_history_storage_domain_id_idx"

  create_table "storage_domain_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                             :null => false
    t.string   "storage_domain_id",             :limit => nil, :null => false
    t.integer  "available_disk_size_gb"
    t.integer  "used_disk_size_gb"
    t.integer  "storage_configuration_version"
  end

  add_index "storage_domain_samples_history", ["history_datetime"], :name => "idx_storage_history_datetime_samples"
  add_index "storage_domain_samples_history", ["storage_configuration_version"], :name => "idx_storage_configuration_version_samples"
  add_index "storage_domain_samples_history", ["storage_domain_id"], :name => "storage_domain_samples_history_storage_domain_id_idx"

  create_table "tag_details", :primary_key => "history_id", :force => true do |t|
    t.string   "tag_id",          :limit => nil,  :null => false
    t.string   "tag_name",        :limit => 50,   :null => false
    t.string   "tag_description", :limit => 4000
    t.string   "tag_path",        :limit => 4000, :null => false
    t.integer  "tag_level",       :limit => 2,    :null => false
    t.datetime "create_date",                     :null => false
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "tag_details", ["tag_id"], :name => "tag_details_tag_id_idx"
  add_index "tag_details", ["tag_level"], :name => "tag_details_tag_level_idx"
  add_index "tag_details", ["tag_path"], :name => "tag_details_tag_path_idx"

  create_table "tag_relations_history", :primary_key => "history_id", :force => true do |t|
    t.string   "entity_id",   :limit => nil, :null => false
    t.integer  "entity_type", :limit => 2,   :null => false
    t.string   "parent_id",   :limit => nil
    t.datetime "attach_date",                :null => false
    t.datetime "detach_date"
  end

  add_index "tag_relations_history", ["entity_id", "attach_date"], :name => "ix_tag_relations_history"
  add_index "tag_relations_history", ["entity_type"], :name => "ix_tag_relations_history_1"
  add_index "tag_relations_history", ["parent_id"], :name => "tag_relations_history_parent_id_idx"

  create_table "vm_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "vm_id",                              :limit => nil,                     :null => false
    t.string   "vm_name",                                                               :null => false
    t.string   "vm_description",                     :limit => 4000
    t.integer  "vm_type",                            :limit => 2
    t.string   "cluster_id",                         :limit => nil,                     :null => false
    t.string   "template_id",                        :limit => nil,                     :null => false
    t.string   "template_name",                      :limit => 40
    t.integer  "cpu_per_socket",                     :limit => 2
    t.integer  "number_of_sockets",                  :limit => 2
    t.integer  "memory_size_mb"
    t.integer  "operating_system",                   :limit => 2,    :default => 0,     :null => false
    t.string   "ad_domain",                          :limit => 40
    t.string   "default_host",                       :limit => nil
    t.boolean  "high_availability"
    t.boolean  "initialized"
    t.boolean  "stateless"
    t.boolean  "fail_back"
    t.boolean  "auto_suspend",                                       :default => false
    t.integer  "usb_policy",                         :limit => 2
    t.string   "time_zone",                          :limit => 40
    t.integer  "cluster_configuration_version"
    t.integer  "default_host_configuration_version"
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "vm_configuration", ["cluster_id"], :name => "vm_configuration_cluster_id_idx"
  add_index "vm_configuration", ["vm_id"], :name => "vm_configuration_vm_id_idx"

  create_table "vm_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                                                                 :null => false
    t.string  "vm_id",                              :limit => nil,                                                :null => false
    t.integer "vm_status",                          :limit => 2,                                                  :null => false
    t.decimal "minutes_in_status",                                 :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer "cpu_usage_percent",                  :limit => 2,                                 :default => 0
    t.integer "max_cpu_usage",                      :limit => 2
    t.integer "memory_usage_percent",               :limit => 2,                                 :default => 0
    t.integer "max_memory_usage",                   :limit => 2
    t.integer "user_cpu_usage_percent",             :limit => 2,                                 :default => 0
    t.integer "max_user_cpu_usage_percent",         :limit => 2,                                 :default => 0
    t.integer "system_cpu_usage_percent",           :limit => 2,                                 :default => 0
    t.integer "max_system_cpu_usage_percent",       :limit => 2,                                 :default => 0
    t.string  "vm_ip"
    t.string  "current_user_name"
    t.string  "currently_running_on_host",          :limit => nil
    t.integer "vm_configuration_version"
    t.integer "current_host_configuration_version"
  end

  add_index "vm_daily_history", ["current_host_configuration_version"], :name => "idx_vm_current_host_configuration_daily"
  add_index "vm_daily_history", ["history_datetime"], :name => "idx_vm_history_datetime_daily"
  add_index "vm_daily_history", ["vm_configuration_version"], :name => "idx_vm_configuration_version_daily"
  add_index "vm_daily_history", ["vm_id"], :name => "vm_daily_history_vm_id_idx"

  create_table "vm_device_history", :primary_key => "history_id", :force => true do |t|
    t.string   "vm_id",                        :limit => nil,                    :null => false
    t.string   "device_id",                    :limit => nil,                    :null => false
    t.string   "type",                         :limit => 30,                     :null => false
    t.string   "address",                                                        :null => false
    t.boolean  "is_managed",                                  :default => false, :null => false
    t.boolean  "is_plugged"
    t.boolean  "is_readonly",                                 :default => false, :null => false
    t.integer  "vm_configuration_version"
    t.integer  "device_configuration_version"
    t.datetime "create_date",                                                    :null => false
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "vm_device_history", ["vm_id", "type"], :name => "idx_vm_device_history_vm_id_type"

  create_table "vm_disk_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "image_id",                  :limit => nil,  :null => false
    t.string   "storage_domain_id",         :limit => nil
    t.integer  "vm_internal_drive_mapping", :limit => 2
    t.string   "vm_disk_description",       :limit => 4000
    t.integer  "vm_disk_size_mb"
    t.integer  "vm_disk_type",              :limit => 2
    t.integer  "vm_disk_format",            :limit => 2
    t.integer  "vm_disk_interface",         :limit => 2
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
    t.string   "vm_disk_id",                :limit => nil
    t.string   "vm_disk_name"
    t.boolean  "is_shared"
  end

  add_index "vm_disk_configuration", ["image_id"], :name => "vm_disk_configuration_vm_disk_id_idx"
  add_index "vm_disk_configuration", ["storage_domain_id"], :name => "vm_disk_configuration_storage_domain_id_idx"

  create_table "vm_disk_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                                                               :null => false
    t.string  "image_id",                        :limit => nil,                                                 :null => false
    t.integer "vm_disk_status",                  :limit => 2
    t.decimal "minutes_in_status",                              :precision => 7,  :scale => 2, :default => 1.0, :null => false
    t.integer "vm_disk_actual_size_mb",                                                                         :null => false
    t.integer "read_rate_bytes_per_second"
    t.integer "max_read_rate_bytes_per_second"
    t.decimal "read_latency_seconds",                           :precision => 18, :scale => 9
    t.decimal "max_read_latency_seconds",                       :precision => 18, :scale => 9
    t.integer "write_rate_bytes_per_second"
    t.integer "max_write_rate_bytes_per_second"
    t.decimal "write_latency_seconds",                          :precision => 18, :scale => 9
    t.decimal "max_write_latency_seconds",                      :precision => 18, :scale => 9
    t.decimal "flush_latency_seconds",                          :precision => 18, :scale => 9
    t.decimal "max_flush_latency_seconds",                      :precision => 18, :scale => 9
    t.integer "vm_disk_configuration_version"
    t.string  "vm_disk_id",                      :limit => nil
  end

  add_index "vm_disk_daily_history", ["history_datetime"], :name => "idx_vm_disk_history_datetime_daily"
  add_index "vm_disk_daily_history", ["image_id"], :name => "vm_disk_daily_history_vm_disk_id_idx"
  add_index "vm_disk_daily_history", ["vm_disk_configuration_version"], :name => "idx_vm_disk_configuration_version_daily"

  create_table "vm_disk_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                               :null => false
    t.string   "image_id",                        :limit => nil,                                                 :null => false
    t.integer  "vm_disk_status",                  :limit => 2
    t.decimal  "minutes_in_status",                              :precision => 7,  :scale => 2, :default => 1.0, :null => false
    t.integer  "vm_disk_actual_size_mb",                                                                         :null => false
    t.integer  "read_rate_bytes_per_second"
    t.integer  "max_read_rate_bytes_per_second"
    t.decimal  "read_latency_seconds",                           :precision => 18, :scale => 9
    t.decimal  "max_read_latency_seconds",                       :precision => 18, :scale => 9
    t.integer  "write_rate_bytes_per_second"
    t.integer  "max_write_rate_bytes_per_second"
    t.decimal  "write_latency_seconds",                          :precision => 18, :scale => 9
    t.decimal  "max_write_latency_seconds",                      :precision => 18, :scale => 9
    t.decimal  "flush_latency_seconds",                          :precision => 18, :scale => 9
    t.decimal  "max_flush_latency_seconds",                      :precision => 18, :scale => 9
    t.integer  "vm_disk_configuration_version"
    t.string   "vm_disk_id",                      :limit => nil
  end

  add_index "vm_disk_hourly_history", ["history_datetime"], :name => "idx_vm_disk_history_datetime_hourly"
  add_index "vm_disk_hourly_history", ["image_id"], :name => "vm_disk_hourly_history_vm_disk_id_idx"
  add_index "vm_disk_hourly_history", ["vm_disk_configuration_version"], :name => "idx_vm_disk_configuration_version_hourly"

  create_table "vm_disk_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                             :null => false
    t.string   "image_id",                      :limit => nil,                                                 :null => false
    t.integer  "vm_disk_status",                :limit => 2
    t.decimal  "minutes_in_status",                            :precision => 7,  :scale => 2, :default => 1.0, :null => false
    t.integer  "vm_disk_actual_size_mb",                                                                       :null => false
    t.integer  "read_rate_bytes_per_second"
    t.decimal  "read_latency_seconds",                         :precision => 18, :scale => 9
    t.integer  "write_rate_bytes_per_second"
    t.decimal  "write_latency_seconds",                        :precision => 18, :scale => 9
    t.decimal  "flush_latency_seconds",                        :precision => 18, :scale => 9
    t.integer  "vm_disk_configuration_version"
    t.string   "vm_disk_id",                    :limit => nil
  end

  add_index "vm_disk_samples_history", ["history_datetime"], :name => "idx_vm_disk_history_datetime_samples"
  add_index "vm_disk_samples_history", ["image_id"], :name => "vm_disk_samples_history_vm_disk_id_idx"
  add_index "vm_disk_samples_history", ["vm_disk_configuration_version"], :name => "idx_vm_disk_configuration_version_samples"

  create_table "vm_disks_usage_daily_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                :null => false
    t.string   "vm_id",            :limit => nil, :null => false
    t.text     "disks_usage"
  end

  add_index "vm_disks_usage_daily_history", ["history_datetime"], :name => "idx_disks_usage_history_datetime_daily"
  add_index "vm_disks_usage_daily_history", ["vm_id"], :name => "idx_disks_usage_vm_id_daily"

  create_table "vm_disks_usage_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                :null => false
    t.string   "vm_id",            :limit => nil, :null => false
    t.text     "disks_usage"
  end

  add_index "vm_disks_usage_hourly_history", ["history_datetime"], :name => "idx_disks_usage_history_datetime_hourly"
  add_index "vm_disks_usage_hourly_history", ["vm_id"], :name => "idx_disks_usage_vm_id_hourly"

  create_table "vm_disks_usage_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                :null => false
    t.string   "vm_id",            :limit => nil, :null => false
    t.text     "disks_usage"
  end

  add_index "vm_disks_usage_samples_history", ["history_datetime"], :name => "idx_disks_usage_history_datetime_samples"
  add_index "vm_disks_usage_samples_history", ["vm_id"], :name => "idx_disks_usage_vm_id_samples"

  create_table "vm_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                                 :null => false
    t.string   "vm_id",                              :limit => nil,                                                :null => false
    t.integer  "vm_status",                          :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                                 :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "cpu_usage_percent",                  :limit => 2,                                 :default => 0
    t.integer  "max_cpu_usage",                      :limit => 2
    t.integer  "memory_usage_percent",               :limit => 2,                                 :default => 0
    t.integer  "max_memory_usage",                   :limit => 2
    t.integer  "user_cpu_usage_percent",             :limit => 2,                                 :default => 0
    t.integer  "max_user_cpu_usage_percent",         :limit => 2,                                 :default => 0
    t.integer  "system_cpu_usage_percent",           :limit => 2,                                 :default => 0
    t.integer  "max_system_cpu_usage_percent",       :limit => 2,                                 :default => 0
    t.string   "vm_ip"
    t.string   "current_user_name"
    t.string   "currently_running_on_host",          :limit => nil
    t.integer  "vm_configuration_version"
    t.integer  "current_host_configuration_version"
  end

  add_index "vm_hourly_history", ["current_host_configuration_version"], :name => "idx_vm_current_host_configuration_hourly"
  add_index "vm_hourly_history", ["history_datetime"], :name => "idx_vm_history_datetime_hourly"
  add_index "vm_hourly_history", ["vm_configuration_version"], :name => "idx_vm_configuration_version_hourly"
  add_index "vm_hourly_history", ["vm_id"], :name => "vm_hourly_history_vm_id_idx"

  create_table "vm_interface_configuration", :primary_key => "history_id", :force => true do |t|
    t.string   "vm_interface_id",          :limit => nil, :null => false
    t.string   "vm_interface_name",        :limit => 50,  :null => false
    t.string   "vm_id",                    :limit => nil
    t.integer  "vm_interface_type",        :limit => 2
    t.integer  "vm_interface_speed_bps"
    t.string   "mac_address",              :limit => 20
    t.string   "network_name",             :limit => 50
    t.integer  "vm_configuration_version"
    t.datetime "create_date"
    t.datetime "update_date"
    t.datetime "delete_date"
  end

  add_index "vm_interface_configuration", ["vm_id"], :name => "vm_interface_configuration_vm_id_idx"
  add_index "vm_interface_configuration", ["vm_interface_id"], :name => "vm_interface_configuration_vm_interface_id_idx"

  create_table "vm_interface_daily_history", :primary_key => "history_id", :force => true do |t|
    t.date    "history_datetime",                                  :null => false
    t.string  "vm_interface_id",                    :limit => nil, :null => false
    t.integer "receive_rate_percent",               :limit => 2
    t.integer "max_receive_rate_percent",           :limit => 2
    t.integer "transmit_rate_percent",              :limit => 2
    t.integer "max_transmit_rate_percent",          :limit => 2
    t.integer "vm_interface_configuration_version"
  end

  add_index "vm_interface_daily_history", ["history_datetime"], :name => "idx_vm_interface_history_datetime_daily"
  add_index "vm_interface_daily_history", ["vm_interface_configuration_version"], :name => "idx_vm_interface_configuration_version_daily"
  add_index "vm_interface_daily_history", ["vm_interface_id"], :name => "vm_interface_daily_history_vm_interface_id_idx"

  create_table "vm_interface_hourly_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                  :null => false
    t.string   "vm_interface_id",                    :limit => nil, :null => false
    t.integer  "receive_rate_percent",               :limit => 2
    t.integer  "max_receive_rate_percent",           :limit => 2
    t.integer  "transmit_rate_percent",              :limit => 2
    t.integer  "max_transmit_rate_percent",          :limit => 2
    t.integer  "vm_interface_configuration_version"
  end

  add_index "vm_interface_hourly_history", ["history_datetime"], :name => "idx_vm_interface_history_datetime_hourly"
  add_index "vm_interface_hourly_history", ["vm_interface_configuration_version"], :name => "idx_vm_interface_configuration_version_hourly"
  add_index "vm_interface_hourly_history", ["vm_interface_id"], :name => "vm_interface_hourly_history_vm_interface_id_idx"

  create_table "vm_interface_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                  :null => false
    t.string   "vm_interface_id",                    :limit => nil, :null => false
    t.integer  "receive_rate_percent",               :limit => 2
    t.integer  "transmit_rate_percent",              :limit => 2
    t.integer  "vm_interface_configuration_version"
  end

  add_index "vm_interface_samples_history", ["history_datetime"], :name => "idx_vm_interface_history_datetime_samples"
  add_index "vm_interface_samples_history", ["vm_interface_configuration_version"], :name => "idx_vm_interface_configuration_version_samples"
  add_index "vm_interface_samples_history", ["vm_interface_id"], :name => "vm_interface_samples_history_vm_interface_id_idx"

  create_table "vm_samples_history", :primary_key => "history_id", :force => true do |t|
    t.datetime "history_datetime",                                                                                 :null => false
    t.string   "vm_id",                              :limit => nil,                                                :null => false
    t.integer  "vm_status",                          :limit => 2,                                                  :null => false
    t.decimal  "minutes_in_status",                                 :precision => 7, :scale => 2, :default => 1.0, :null => false
    t.integer  "cpu_usage_percent",                  :limit => 2,                                 :default => 0
    t.integer  "memory_usage_percent",               :limit => 2,                                 :default => 0
    t.integer  "user_cpu_usage_percent",             :limit => 2,                                 :default => 0
    t.integer  "system_cpu_usage_percent",           :limit => 2,                                 :default => 0
    t.string   "vm_ip"
    t.string   "current_user_name"
    t.string   "currently_running_on_host",          :limit => nil
    t.integer  "vm_configuration_version"
    t.integer  "current_host_configuration_version"
  end

  add_index "vm_samples_history", ["current_host_configuration_version"], :name => "idx_vm_current_host_configuration_samples"
  add_index "vm_samples_history", ["history_datetime"], :name => "idx_vm_history_datetime_samples"
  add_index "vm_samples_history", ["vm_configuration_version"], :name => "idx_vm_configuration_version_samples"
  add_index "vm_samples_history", ["vm_id"], :name => "vm_samples_history_vm_id_idx"

end
