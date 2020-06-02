require 'spec_helper'

module Pandas
  ::RSpec.describe Index do
    describe '#monotonic?' do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        expect(idx).to be_monotonic
      end

      specify do
        idx = Pandas::Index.new([5, 4, 3, 2, 1])
        expect(idx).not_to be_monotonic
      end

      specify do
        idx = Pandas::Index.new([1, 2, 6, 4, 5])
        expect(idx).not_to be_monotonic
      end
    end

    describe '#monotonic_decreasing?' do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        expect(idx).not_to be_monotonic_decreasing
      end

      specify do
        idx = Pandas::Index.new([5, 4, 3, 2, 1])
        expect(idx).to be_monotonic_decreasing
      end

      specify do
        idx = Pandas::Index.new([1, 2, 6, 4, 5])
        expect(idx).not_to be_monotonic_decreasing
      end
    end

    describe '#monotonic_increasing?' do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        expect(idx).to be_monotonic_increasing
      end

      specify do
        idx = Pandas::Index.new([5, 4, 3, 2, 1])
        expect(idx).not_to be_monotonic_increasing
      end

      specify do
        idx = Pandas::Index.new([1, 2, 6, 4, 5])
        expect(idx).not_to be_monotonic_increasing
      end
    end

    describe '#unique?' do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        expect(idx).to be_unique
      end

      specify do
        idx = Pandas::Index.new([1, 5, 3, 4, 5])
        expect(idx).not_to be_unique
      end
    end
  end
end
