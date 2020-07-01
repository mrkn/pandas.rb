require 'pandas'

module Pandas
  class DataFrame
    def [](key)
      key = PyCall::List.new(key) if key.is_a?(Array)
      super
    end
  end
end
