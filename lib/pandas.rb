require "pandas/version"
require "pycall"

Pandas = PyCall.import_module('pandas')
module Pandas
  VERSION = PANDAS_VERSION
  Object.send :remove_const, :PANDAS_VERSION

  DataFrame = self.core.frame.DataFrame
  Series = self.core.series.Series
  IlocIndexer = self.core.indexing._iLocIndexer
  LocIndexer = self.core.indexing._LocIndexer
  IXIndexer = self.core.indexing._IXIndexer
  MultiIndex = self.core.indexing.MultiIndex
  DatetimeIndex = self.core.indexes.datetimes.DatetimeIndex
  Index = self.core.index.Index
  DataFrameGroupBy = self.core.groupby.DataFrameGroupBy
  SeriesGroupBy = self.core.groupby.SeriesGroupBy
  IO = self.io

  def self.read_sql_table(table_name, conn, *args)
    if IO.is_activerecord_datasource?(conn)
      require 'pandas/io/active_record'
      return IO.read_sql_table_from_active_record(table_name, conn, *args)
    end
    super
  end

  require 'pandas/io'
  require 'pandas/options'
end
