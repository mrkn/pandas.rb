require 'spec_helper'

module Pandas
  ::RSpec.describe Index do
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

    describe "#length" do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        expect(idx.length).to eq(5)
      end
    end

    describe "#to_a" do
      specify do
        idx = Pandas::Index.new([1, 2, 3, 4, 5])
        a = idx.to_a
        expect(a).to be_an(Array)
        expect(a).to eq([1, 2, 3, 4, 5])
      end

      context "after dropna" do
        specify "without NaNs" do
          s = Pandas::Index.new([1, 2, 3, 4, 5])
          a = s.dropna.to_a
          expect(a).to be_an(Array)
          expect(a).to eq([1, 2, 3, 4, 5])
        end

        specify "with NaNs" do
          s = Pandas::Index.new([1, 2, nil, 4, 5])
          a = s.dropna.to_a
          expect(a).to be_an(Array)
          expect(a).to eq([1, 2, 4, 5])
        end
      end
    end
  end
end
