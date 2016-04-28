require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/array'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/bit'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/bit_varying'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/bytea'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/cidr'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/date_time'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/decimal'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/enum'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/hstore'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/inet'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/json'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/jsonb'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/money'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/point'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/rails_5_1_point'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/range'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/specialized_string'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/uuid'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/vector'
require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/xml'

require 'active_record/connection_adapters/ovirt_legacy_postgresql/oid/type_map_initializer'

module ActiveRecord
  module ConnectionAdapters
    module OvirtLegacyPostgreSQL
      module OID # :nodoc:
      end
    end
  end
end
