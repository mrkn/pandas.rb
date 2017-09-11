require 'pandas'

module Pandas
  class DataFrame
    def [](*key)
      if key.length == 1 && key[0].is_a?(Array)
        key[0] = PyCall::List.new(key[0])
      end
      super
    end
  end
end
