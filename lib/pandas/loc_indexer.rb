require 'pandas'

module Pandas
  class LocIndexer
    def [](*keys)
      if keys.length == 1 && keys[0].is_a?(Array)
        keys[0] = PyCall::List.new(keys[0])
      end
      super
    end
  end
end
