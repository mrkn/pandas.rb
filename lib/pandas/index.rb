require 'pandas'

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
  end
end
