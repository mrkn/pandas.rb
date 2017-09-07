require 'pathname'

module RSpecHelper
  module FileFixture
    def file_fixture_path
      @file_fixture_path ||= File.expand_path('../../fixtures/files', __FILE__)
    end

    def file_fixture(fixture_name)
      path = Pathname.new(file_fixture_path).join(fixture_name)
      if path.exist?
        path
      else
        msg = "the directory '%s' does not contain a file named '%s'"
        raise ArgumentError, msg % [file_fixture_path, fixture_name]
      end
    end
  end
end

RSpec.configuration.include RSpecHelper::FileFixture
