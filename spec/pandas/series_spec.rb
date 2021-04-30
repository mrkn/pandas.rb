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

      context 'When the key is a Range' do
        subject(:series) do
          Pandas::Series.new([10, 20, 30, 40], index: %w[x1 x2 x3 x4])
        end

        context 'The Range is close-end' do
          specify do
            expect(series["x2".."x3"]).to eq([20, 30])
          end
        end

        context 'The Range is open-end' do
          specify do
            expect(series["x2"..."x4"].values).to eq([20, 30, 40])
          end
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

    describe "#length" do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        expect(s.length).to eq(5)
      end
    end

    describe "#to_a" do
      specify do
        s = Pandas::Series.new([1, 2, 3, 4, 5])
        a = s.to_a
        expect(a).to be_an(Array)
        expect(a).to eq([1, 2, 3, 4, 5])
      end

      context "after dropna" do
        specify "without NaNs" do
          s = Pandas::Series.new([1, 2, 3, 4, 5])
          a = s.dropna.to_a
          expect(a).to be_an(Array)
          expect(a).to eq([1, 2, 3, 4, 5])
        end

        specify "with NaNs" do
          s = Pandas::Series.new([1, 2, nil, 4, 5])
          a = s.dropna.to_a
          expect(a).to be_an(Array)
          expect(a).to eq([1, 2, 4, 5])
        end
      end
    end
  end
end
