# The chenge history of Pandas wrapper for Ruby

## 0.3.8

* Add `to_iruby_mimebundle` in `Pandas::DataFrame`

## 0.3.7

* Avoid circular require warning

## 0.3.6

* Add `to_narray` in `Pandas::DataFrame`, `Pandas::Series`, and `Pandas::Index`

## 0.3.5

* Fix the bug of `to_a` for Series after doing dropna

## 0.3.4

* Add `to_a` methods in `Pandas::Series` and `Pandas::Index`

* Add `length` method in `Pandas::Series` and `Pandas::Index`

## 0.3.3

* Support array index in `Pandas::Series#[]`

* Add predicate methods for `Pandas::Index` and `Pandas::Series`

* Support closed-end string ranges in `Pandas::Series#[]`

* Support string array index in `Pandas::DataFrame#loc[]`

* Support array index in `Pandas::DataFrame#iloc[]`

## 0.3.2

* Fix for pandas 1.0

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
