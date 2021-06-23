require 'pandas' unless defined?(Pandas)

module Pandas
  module OptionsHelper
    module_function

    def setup_options(options)
      PyCall::LibPython::Helpers.define_wrapper_method(options, :display)
      options
    end
  end

  def self.options
    @options ||= begin
                   o = PyCall::LibPython::Helpers.getattr(__pyptr__, :options)
                   OptionsHelper.setup_options(o)
                 end
  end
end
