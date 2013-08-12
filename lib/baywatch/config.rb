module Baywatch
  
  class Config
    attr_accessor :configurations
    
    def initialize
      @configurations = {}
    end

    def include?(action)
      @configurations.keys.include?(action.to_sym)
    end

    def [](val)
      @configurations[val.to_sym]
    end

    def only(*args, &block)
      args.each do |action|
        @configurations[action.to_sym] = block
      end 
    end

    def method_missing(method, *args, &block)
      raise "You should pass one Block #{method}" if block.nil?
      @configurations[method.to_sym] = block
    end

  end

end