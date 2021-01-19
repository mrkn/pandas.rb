# Pandas wrapper for Ruby

[![CI](https://github.com/mrkn/pandas.rb/workflows/CI/badge.svg?branch=master&event=push)](https://github.com/mrkn/pandas.rb/actions?query=workflow%3ACI)

This library enables to directry call [pandas](http://pandas.pydata.org/) from Ruby language.
This uses [pycall](https://github.com/mrkn/pycall).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pandas'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pandas

## Usage

Example usage:

```ruby
require 'pandas'
df = Pandas.read_csv('data/titanic.csv')

puts df.groupby(:Sex)[:Survived].describe
#         count      mean       std  min  25%  50%  75%  max
# Sex
# female  314.0  0.742038  0.438211  0.0  0.0  1.0  1.0  1.0
# male    573.0  0.190227  0.392823  0.0  0.0  0.0  0.0  1.0

puts df.groupby(:Sex)[:Age].describe
#         count       mean        std   min   25%   50%   75%   max
# Sex
# female  314.0  27.719745  13.834740  0.75  18.0  27.0  36.0  63.0
# male    573.0  30.431361  14.197273  0.42  21.0  28.0  38.0  80.0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mrkn/pandas.rb.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
