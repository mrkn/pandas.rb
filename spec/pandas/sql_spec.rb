require 'spec_helper'
require 'csv'

::RSpec.describe Pandas, :with_database do
  let(:sqlalchemy) do
    PyCall.import_module('sqlalchemy')
  end

  let(:engine) do
    sqlalchemy.create_engine('sqlite:///' + database_path)
  end

  before do
    PyCall.with(engine.connect) do |conn|
      conn.execute <<-SQL
create table people (
  id integer primary key,
  name string,
  age integer,
  sex string
);
      SQL
      csv = CSV.read(file_fixture('people.csv'), headers: :first_row)
      csv.each do |row|
        conn.execute <<-SQL
insert into people (id, name, age, sex) values (#{row['id']}, "#{row['name']}", #{row['age']}, "#{row['sex']}");
        SQL
      end
    end
  end

  describe '.read_sql_table' do
    context 'When the given connection is of SQLAlchemy' do
      it 'reads from SQLAlchemy engine' do
        df_sql = Pandas.read_sql_table('people', engine)
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_sql).to eq(df_csv)
      end
    end
  end

  describe '.read_sql_query' do
    context 'When the given connection is of SQLAlchemy' do
      it 'reads from SQLAlchemy engine' do
        df_sql = Pandas.read_sql_query(<<-SQL, engine)
select name, sex from people;
        SQL
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_sql).to eq(df_csv[[:name, :sex]])
      end
    end
  end
end
