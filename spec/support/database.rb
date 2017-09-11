RSpec.shared_context 'With database', :with_database do
  require 'active_record'
  require 'fileutils'

  let(:tmp_dir) do
    File.expand_path('../../../tmp', __FILE__)
  end

  let(:database_path) do
    File.join(tmp_dir, 'test.sqlite3')
  end

  let(:connection_config) do
    {adapter: :sqlite3, database: database_path, pool: 5, timeout: 5000}
  end

  before do
    FileUtils.rm_f(database_path)
    ActiveRecord::Base.establish_connection(connection_config)
  end
end
