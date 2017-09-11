require 'spec_helper'
require 'csv'

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
  end

  describe '.read_sql_table' do
    context 'When the given connection is of ActiveRecord' do
      it 'reads from ActiveRecord connection' do
        df_ar  = Pandas.read_sql_table('people', ActiveRecord::Base.connection)
        df_csv = Pandas.read_csv(file_fixture('people.csv').to_s)
        expect(df_ar).to eq(df_csv)
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
    end
  end
end
