require "pandas/version"
require "pycall"

Pandas = PyCall.import_module('pandas')
module Pandas
  VERSION = PANDAS_VERSION
  Object.send :remove_const, :PANDAS_VERSION

  DataFrame = self.core.frame.DataFrame
  DataFrame.__send__ :register_python_type_mapping

  Series = self.core.series.Series
  Series.__send__ :register_python_type_mapping

  IlocIndexer = self.core.indexing._iLocIndexer
  IlocIndexer.__send__ :register_python_type_mapping

  LocIndexer = self.core.indexing._LocIndexer
  LocIndexer.__send__ :register_python_type_mapping

  IXIndexer = self.core.indexing._IXIndexer
  IXIndexer.__send__ :register_python_type_mapping

  MultiIndex = self.core.indexing.MultiIndex
  MultiIndex.__send__ :register_python_type_mapping

  DatetimeIndex = self.core.indexes.datetimes.DatetimeIndex
  DatetimeIndex.__send__ :register_python_type_mapping

  Index = self.core.index.Index
  Index.__send__ :register_python_type_mapping

  DataFrameGroupBy = self.core.groupby.DataFrameGroupBy
  DataFrameGroupBy.__send__ :register_python_type_mapping

  SeriesGroupBy = self.core.groupby.SeriesGroupBy
  SeriesGroupBy.__send__ :register_python_type_mapping

  IO = self.io

  def self.read_sql_table(table_name, conn=nil, *args)
    if conn.nil? && IO.is_activerecord_model?(table_name)
      unless table_name.table_name
        raise ArgumentError, "The given model does not have its table_name"
      end
      table_name, conn = table_name.table_name, table_name.connection
    end

    unless conn
      raise ArgumentError, "wrong number of arguments (given 1, expected 2+)"
    end

    if IO.is_activerecord_datasource?(conn)
      require 'pandas/io/active_record'
      return IO::Helpers.read_sql_table_from_active_record(table_name, conn, *args)
    end
    super
  end

  def self.read_sql_query(query, conn, *args)
    if IO.is_activerecord_datasource?(conn)
      require 'pandas/io/active_record'
      return IO::Helpers.read_sql_query_from_active_record(query, conn, *args)
    end
    super
  end

  require 'pandas/data_frame'
  require 'pandas/io'
  require 'pandas/options'
end
