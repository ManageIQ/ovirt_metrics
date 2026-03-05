module ActiveRecord
  module ConnectionHandling # :nodoc:
    def ovirt_postgresql_connection(config)
      conn_params = config.symbolize_keys

      conn_params.delete_if { |_, v| v.nil? }

      conn_params[:user] = conn_params.delete(:username) if conn_params[:username]
      conn_params[:dbname] = conn_params.delete(:database) if conn_params[:database]

      valid_conn_param_keys = PG::Connection.conndefaults_hash.keys + [:requiressl]
      conn_params.slice!(*valid_conn_param_keys)

      conn = PG.connect(conn_params) if ActiveRecord::VERSION::MAJOR >= 6
      ConnectionAdapters::OvirtPostgreSQLAdapter.new(conn, logger, conn_params, config)
    end
  end

  module ConnectionAdapters
    require 'active_record/connection_adapters/postgresql_adapter'

    class OvirtPostgreSQLAdapter < PostgreSQLAdapter
      ADAPTER_NAME = "OvirtPostgreSQL"

      # ActiveRecord 7.2 introduced a .register method for connection adapters,
      # replacing the auto-require with path based on adapter name.
      # Without registering the adapter active_record won't be able to find the
      # ovirt_postgresql adapter.
      if ActiveRecord::VERSION::MAJOR > 7 || (ActiveRecord::VERSION::MAJOR == 7 && ActiveRecord::VERSION::MINOR >= 2)
        ActiveRecord::ConnectionAdapters.register('ovirt_postgresql', name, 'active_record/connection_adapters/ovirt_postgresql_adapter')
      end

      def check_version
        msg = "The version of PostgreSQL (#{postgresql_version}) is too old (9.2+ required)"
        if postgresql_version < 90200
          raise msg
        end
      end
    end
  end
end
