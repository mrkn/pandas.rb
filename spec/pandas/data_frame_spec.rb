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
  end
end
