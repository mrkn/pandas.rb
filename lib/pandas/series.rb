require 'pandas' unless defined?(Pandas)

module Pandas
  class Series
    def [](*key)
      if key.length == 1
        case key[0]
        when Array
          key[0] = PyCall::List.new(key[0])
        when Range
          case key[0].begin
          when String
            key[0] = key[0].begin ... key[0].end # force exclude-end
          end
        end
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

    def length
      size
    end

    def to_a
      Array.new(length) {|i| self.iloc[i] }
    end

    def to_narray
      to_numpy.to_narray
    end
  end
end
