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
  end
end
