require "pandas/version"
require "numpy"

Pandas = PyCall.import_module("pandas")
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

  if self.__version__ < "1.0"
    IXIndexer = self.core.indexing._IXIndexer
    IXIndexer.__send__ :register_python_type_mapping
  end

  if self.__version__ >= "1.0"
    MultiIndex = self.core.indexes.multi.MultiIndex
  else
    MultiIndex = self.core.indexing.MultiIndex
  end
  MultiIndex.__send__ :register_python_type_mapping

  DatetimeIndex = if self.__version__ >= "0.20"
                    self.core.indexes.datetimes.DatetimeIndex
                  else
                    self.tseries.index.DatetimeIndex
                  end
  DatetimeIndex.__send__ :register_python_type_mapping

  if self.__version__ >= "1.0"
    Index = self.core.indexes.base.Index
  else
    Index = self.core.index.Index
  end
  Index.__send__ :register_python_type_mapping

  DataFrameGroupBy = self.core.groupby.DataFrameGroupBy
  DataFrameGroupBy.__send__ :register_python_type_mapping

  SeriesGroupBy = self.core.groupby.SeriesGroupBy
  SeriesGroupBy.__send__ :register_python_type_mapping

  IO = self.io

  def self.read_sql_table(table_name, conn=nil, *args, **kwargs)
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
      return IO::Helpers.read_sql_table_from_active_record(table_name, conn, *args, **kwargs)
    end
    super
  end

  def self.read_sql_query(query, conn, *args, **kwargs)
    if IO.is_activerecord_datasource?(conn)
      require 'pandas/io/active_record'
      return IO::Helpers.read_sql_query_from_active_record(query, conn, *args, **kwargs)
    end
    super
  end

  require 'pandas/data_frame'
  require 'pandas/index'
  require 'pandas/io'
  require 'pandas/loc_indexer'
  require 'pandas/options'
  require 'pandas/series'
end
