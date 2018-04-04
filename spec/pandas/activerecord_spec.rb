require 'spec_helper'
require 'csv'

module PandasActiveRecordSpec
end

::RSpec.describe Pandas, :with_database do
  before do
    ActiveRecord::Base.connection.execute <<-SQL
create table people (
id integer primary key,
name string,
age integer,
sex string
);
    SQL
    csv = CSV.read(file_fixture('people.csv'), headers: :first_row)
    csv.each do |row|
      ActiveRecord::Base.connection.execute <<-SQL
insert into people (id, name, age, sex) values (#{row['id']}, "#{row['name']}", #{row['age']}, "#{row['sex']}");
      SQL
    end

    class PandasActiveRecordSpec::Person < ActiveRecord::Base
      self.table_name = 'people'
    end
  end

  after do
    module PandasActiveRecordSpec
      remove_const :Person
    end
  end

  describe '.read_sql_table' do
    context 'When the given connection is of ActiveRecord' do
      it 'reads from ActiveRecord connection' do
        df_ar  = Pandas.read_sql_table('people', ActiveRecord::Base.connection)
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_ar).to eq(df_csv)
      end
    end

    context 'When the given object is a concrete ActiveRecord model class' do
      it 'reads from the table of the given model class' do
        df_ar  = Pandas.read_sql_table(PandasActiveRecordSpec::Person)
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_ar).to eq(df_csv)
      end

      context 'with index_col: :id' do
        it 'reads from the table of the given model class' do
          df_ar  = Pandas.read_sql_table(PandasActiveRecordSpec::Person, index_col: :id)
          df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
          expect(df_ar.reset_index).to eq(df_csv)
        end
      end
    end
  end

  describe '.read_sql_query' do
    context 'When the given connection is of ActiveRecord' do
      it 'reads from ActiveRecord connection' do
        df_ar  = Pandas.read_sql_query(<<-SQL, ActiveRecord::Base.connection)
select name, sex from people;
        SQL
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_ar).to eq(df_csv[[:name, :sex]])
      end

      context 'with index_col: :id' do
        it 'reads from ActiveRecord connection' do
          df_ar  = Pandas.read_sql_query(<<-SQL, ActiveRecord::Base.connection, index_col: :id)
select id, name, sex from people;
          SQL
          df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
          expect(df_ar.reset_index(drop: true)).to eq(df_csv[[:name, :sex]])
        end
      end
    end
  end
end
