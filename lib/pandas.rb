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
end
