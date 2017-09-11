require 'pandas'
require 'active_record'

module Pandas
  module IO
    module Helpers
      module_function

      def read_sql_table_from_active_record(table_name, conn, *args)
        case conn
        when ActiveRecord::ConnectionAdapters::AbstractAdapter
          read_sql_table_from_active_record_connection(table_name, conn, *args)
        else
          raise TypeError, "unexpected type of argument #{conn.class}"
        end
      end

      def read_sql_query_from_active_record(query, conn, *args)
        case conn
        when ActiveRecord::ConnectionAdapters::AbstractAdapter
          read_sql_query_from_active_record_connection(query, conn, *args)
        else
          raise TypeError, "unexpected type of argument #{conn.class}"
        end
      end

      def read_sql_table_from_active_record_connection(table_name, conn, *args)
        args = parse_read_sql_table_args(*args)
        index_col, coerce_float, parse_dates, columns, schema, chunksize = *args
        if columns
          table_columns = conn.columns(table_name)
          column_names = columns.select {|c| table_columns.include?(c) }.map do |c|
            conn.quote_column_name(c.to_s)
          end
        else
          column_names = '*'
        end
        query = <<-SQL
  select #{column_names} from #{conn.quote_table_name(table_name)};
        SQL
        # TODO: chunksize
        result = conn.exec_query(query, 'pandas_sql')
        data_frame_from_query_result(result, index_col, coerce_float, parse_dates)
      end

      def read_sql_query_from_active_record_connection(query, conn, *args)
        args = parse_read_sql_query_args(*args)
        index_col, coerce_float, parse_dates, chunksize = *args
        # TODO: chunksize
        result = conn.exec_query(query, 'pandas_sql')
        data_frame_from_query_result(result, index_col, coerce_float, parse_dates)
      end

      def data_frame_from_query_result(result, index_col, coerce_float, parse_dates)
        records = result.map {|row| row.values }
        df = Pandas::DataFrame.from_records(
          records,
          columns: result.columns,
          coerce_float: coerce_float
        )
        # TODO: self.sql._harmonize_columns(parse_dates: parse_dates)
        df.set_index(index_col, inplace: true) if index_col
        df
      end

      def parse_read_sql_table_args(*args)
        kwargs = args.pop if args.last.is_a? Hash
        if kwargs
          names = [:index_col, :coerce_float, :parse_dates, :columns, :schema, :chunksize]
          names.each_with_index do |name, index|
            if kwargs.has_key? name
              if args[index]
                warn "#{name} is given as both positional and keyword arguments"
              else
                args[index] = kwargs[name]
              end
            end
          end
        end
        args
      end

      def parse_read_sql_query_args(*args)
        kwargs = args.pop if args.last.is_a? Hash
        if kwargs
          names = [:index_col, :coerce_float, :parse_dates, :chunksize]
          names.each_with_index do |name, index|
            if kwargs.has_key? name
              if args[index]
                warn "#{name} is given as both positional and keyword arguments"
              else
                args[index] = kwargs[name]
              end
            end
          end
        end
        args
      end
    end
  end
end
