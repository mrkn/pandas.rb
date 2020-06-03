require 'spec_helper'

module Pandas
  ::RSpec.describe DataFrame do
    let(:values) do
      [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12]
      ]
    end

    subject(:df) do
      Pandas::DataFrame.new(values, index: %w[r1 r2 r3], columns: %w[x1 x2 x3 x4])
    end

    describe '#[key]' do
      context 'When the key is an Array' do
        specify do
          expect(df[["x1", "x3"]].iloc[0]).to eq([1, 3])
        end
      end
    end

    describe '#loc[key]' do
      context 'When the key is a String' do
        specify do
          expect(df.loc["r3"]).to eq([9, 10, 11, 12])
        end
      end

      context 'When the key is a string array' do
        let(:expected_result) do
          Pandas::DataFrame.new([values[2], values[0]],
                                index: %w[r3 r1],
                                columns: df.columns)
        end

        specify do
          expect(df.loc[["r3", "r1"]]).to eq(expected_result)
        end
      end
    end
  end
end
