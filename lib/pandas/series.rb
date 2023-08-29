require 'pandas' unless defined?(Pandas)

module Pandas
  class Series
    def [](*key)
      if key.length == 1
        key[0] = fix_array_reference_key(key[0])
      end
      super
    end

    def []=(*args)
      if args.length == 2
        args[0] = fix_array_reference_key(args[0])
      end
      super
    end

    private def fix_array_reference_key(key)
      case key
      when Array
        PyCall::List.new(key)
      when Range
        case key.begin
        when String
          # Force exclude-end
          key.begin ... key.end
        else
          key
        end
      else
        key
      end
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
