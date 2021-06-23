require 'pandas' unless defined?(Pandas)

module Pandas
  class Index
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

    def length
      size
    end

    def to_a
      Array.new(length) {|i| self[i] }
    end

    def to_narray
      to_numpy.to_narray
    end
  end
end
