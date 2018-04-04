# The chenge history of Pandas wrapper for Ruby

## 0.3.1

* Fix `Pandas.read_sql_table` for passing optional parameters such as `index_col`

## 0.3.0

* Fix the module path of `DatetimeIndex` to support pandas < 0.20

  Fixes #5

  *Daniel Baark*

* Support to pass an AR model class to `read_sql_table` instead of both `table_name` and `conn`

## 0.2.0

* Support a connection of ActiveRecord in `read_sql_table` and `read_sql_query`

* Call `register_python_type_mapping` for all wrapper classes

* Support an array index in `DataFrame#[]`

* Fix `Pandas.options.display`

## 0.1.0

* Define some wrapper classes
