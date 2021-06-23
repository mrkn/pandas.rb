require 'pandas' unless defined?(Pandas)

module Pandas
  class LocIndexer
    def [](*keys)
      for i in 0...keys.length
        if keys[i].is_a? Array
          keys[i] = PyCall::List.new(keys[i])
        end
      end
      super
    end
  end

  class IlocIndexer
    def [](*keys)
      for i in 0...keys.length
        if keys[i].is_a? Array
          keys[i] = PyCall::List.new(keys[i])
        end
      end
      super
    end
  end
end
