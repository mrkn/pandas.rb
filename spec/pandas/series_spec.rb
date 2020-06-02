require 'spec_helper'

module Pandas
  ::RSpec.describe Series do
    describe '#[key]' do
      let(:series) do
        Series.new([5, 8, -2, 1], index: ['c', 'a', 'd', 'b'])
      end

      let(:index) do
        ['c', 'b']
      end

      context 'When the key is a PyCall::List' do
        specify do
          list = PyCall::List.new(index)
          expect(series[list]).to eq(Series.new([5, 1], index: index))
        end
      end

      context 'When the key is an Array' do
        specify do
          expect(series[index]).to eq(Series.new([5, 1], index: index))
        end
      end
    end

    describe '#monotonic?' do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        expect(s).to be_monotonic
      end

      specify do
        s = Pandas::Series.new([5, 4, 3, 2, 1])
        expect(s).not_to be_monotonic
      end

      specify do
        s = Pandas::Series.new([1, 2, 6, 4, 5])
        expect(s).not_to be_monotonic
      end
    end

    describe '#monotonic_decreasing?' do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        expect(s).not_to be_monotonic_decreasing
      end

      specify do
        s = Pandas::Series.new([5, 4, 3, 2, 1])
        expect(s).to be_monotonic_decreasing
      end

      specify do
        s = Pandas::Series.new([1, 2, 6, 4, 5])
        expect(s).not_to be_monotonic_decreasing
      end
    end

    describe '#monotonic_increasing?' do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        expect(s).to be_monotonic_increasing
      end

      specify do
        s = Pandas::Series.new([5, 4, 3, 2, 1])
        expect(s).not_to be_monotonic_increasing
      end

      specify do
        s = Pandas::Series.new([1, 2, 6, 4, 5])
        expect(s).not_to be_monotonic_increasing
      end
    end

    describe '#unique?' do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        expect(s).to be_unique
      end

      specify do
        s = Pandas::Series.new([1, 5, 3, 4, 5])
        expect(s).not_to be_unique
      end
    end
  end
end
