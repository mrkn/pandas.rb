require "spec_helper"

RSpec.describe Pandas do
  it "has a version number" do
    expect(Pandas::VERSION).not_to be nil
  end

  specify do
    expect(Pandas).to be_const_defined(:DataFrame)
    expect(Pandas).to be_const_defined(:Series)
    expect(Pandas).to be_const_defined(:IlocIndexer)
    expect(Pandas).to be_const_defined(:LocIndexer)
    expect(Pandas).to be_const_defined(:IXIndexer)
    expect(Pandas).to be_const_defined(:MultiIndex)
    expect(Pandas).to be_const_defined(:Index)
    expect(Pandas).to be_const_defined(:DataFrameGroupBy)
    expect(Pandas).to be_const_defined(:SeriesGroupBy)
  end

  specify do
    df = Pandas.read_csv(file_fixture('test.csv').to_s)
    expect(df).to be_a(Pandas::DataFrame)
  end

  describe '.options.display' do
    specify do
      expect(Pandas.options.display.max_rows).to be_a(Integer)

      begin
        origin_value = Pandas.options.display.max_rows
        half = origin_value >> 1
        expect {
          Pandas.options.display.max_rows = half
        }.to change {
          Pandas.options.display.max_rows
        }.to(half)
      ensure
        Pandas.options.display.max_rows = origin_value
      end
    end
  end
end

module Pandas
  ::RSpec.describe DataFrame do
    specify do
      df = DataFrame.new(data: { name: %w[a b], age: [27, 30] })
      age = df[:age].values()
      age[1] = 31
      expect(df.loc[1, :age]).to eq(31)
    end
  end
end
