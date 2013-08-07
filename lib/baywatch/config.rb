module Baywatch
  
  class Config
    attr_accessor :configurations
    
    def initialize
      @configurations = {}
    end

    def [](val)
      @configurations[val.to_sym]
    end

    def method_missing(method,*args, &block)
      @configurations[method.to_sym] = block
      self.class_eval do 
        define_method method do 
          @configurations[method.to_sym]
        end
      end
    end
  end

end