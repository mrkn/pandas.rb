require 'spec_helper'

module Pandas
  ::RSpec.describe DataFrame do
    describe '#[key]' do
      context 'When the key is an Array' do
        specify do
          df = Pandas.read_csv(file_fixture('people.csv').to_s)
          expect(df[['name', 'sex']].iloc[0]).to eq(['matz', 'male'])
        end
      end
    end

    describe '#loc[key]' do
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
