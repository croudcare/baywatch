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
        
        private
        def define_rescues(exceptions, configuration)
          
          self.class_eval do
            define_method :baywatch do |exception|
              block =  configuration[request.filtered_parameters["action"]]
              self.instance_eval &block unless block.nil?
            end
          end
      
          self.rescue_from *exceptions, :with => :baywatch
        end
      end
    end
  end
end