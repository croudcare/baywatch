module Baywatch

  module Rescue
    
    def self.included(base)
      base.instance_eval do 

        def service_down(*exceptions, &block)
          on = Baywatch::Config.new
          block.call(on)
          define_rescues(exceptions, on)
        end

        def define_rescues(exceptions, configuration)
          self.class_eval do
            define_method :baywatch do |exception|
              block =  configuration[request.filtered_parameters["action"]]
              self.instance_eval &block
            end
          end
      
          self.rescue_from *exceptions, :with => :baywatch
        end
      end
    end

  end
end