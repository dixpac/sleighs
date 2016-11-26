module ActiveRecord
  module ConnectionAdapter
    class SqliteAdapter
      def initialize(file)
        require "sqlite3"
        @db = SQLite3::Database.new(file.to_s, results_as_hash: true)
      end

      # Execute an SQL query and return the results as an array of hashes.
      # Eg.:
      #
      #   > adapter.execute "SELECT * FROM users"
      #   => [
      #     { id: 1, name: "David" },
      #     { id: 2, name: "Aaron" }
      #   ]
      #
      def execute(sql)
        @db.execute(sql).each do |row|
          row.keys.each do |key|
            value = row.delete(key)
            # Only keep string keys (ignores index-based key, 0, 1, ...)
            if key.is_a? String
              row[key.to_sym] = value
            end
          end
        end
      end

      # Return the column names of a table.
      def columns(table_name)
        @db.table_info(table_name).map { |info| info["name"].to_sym }
      end
    end
  end
end
