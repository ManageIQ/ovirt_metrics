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
    class OvirtPostgreSQLAdapter < PostgreSQLAdapter
      ADAPTER_NAME = "OvirtPostgreSQL"

      def check_version
        msg = "The version of PostgreSQL (#{postgresql_version}) is too old (9.2+ required)"
        if postgresql_version < 90200
          raise msg
        end
      end
    end
  end
end
