require 'pry'
module Baywatch
  module Rescue
    
    DEFAULT_EXCEPTIONS = [ Errno::ECONNREFUSED, Errno::ECONNRESET ]

    def self.included(base)
      base.instance_eval do 

        def service_down(*exceptions, &block)
          on = Baywatch::Config.new
          block.call(on)
          exceptions_appended = exceptions.unshift(*DEFAULT_EXCEPTIONS)
          define_rescues(exceptions_appended, on)
        end
        

        def define_rescues(exceptions, configuration)
          self.class_eval do
            
            def baywatch_requested_action
              request.filtered_parameters["action"]
            end

            define_method :baywatch do |exception|
              raise exception unless configuration.include? baywatch_requested_action
              block =  configuration[baywatch_requested_action]
              self.instance_eval &block
            end
          end
      
          self.rescue_from *exceptions, :with => :baywatch
        end
      end
    end
  end
end