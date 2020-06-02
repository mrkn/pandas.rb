require 'pandas'

module Pandas
  class Series
    def [](*key)
      if key.length == 1 && key[0].is_a?(Array)
        key[0] = PyCall::List.new(key[0])
      end
      super
    end

    def monotonic?
      is_monotonic
    end

    def monotonic_decreasing?
      is_monotonic_decreasing
    end

    def monotonic_increasing?
      is_monotonic_increasing
    end

    def unique?
      is_unique
    end
  end
end