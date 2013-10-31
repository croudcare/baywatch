module Baywatch
  module Rescue
    
    DEFAULT_EXCEPTIONS = [ Errno::ETIMEDOUT, Errno::ECONNREFUSED, Errno::ECONNRESET ]

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def service_down(*exceptions, &block)
        on = Baywatch::Config.new
        block.call(on)
        exceptions_appended = exceptions.unshift(*DEFAULT_EXCEPTIONS)
        define_rescues(exceptions_appended, on)
      end
        
      private

      def define_rescues(exceptions, configuration)
          define_baywatch_requested_action
          define_baywatch(configuration)
          register_rescue_from(exceptions)
        end
        
      def define_baywatch_requested_action
        self.class_eval do 
          def baywatch_requested_action
            request.filtered_parameters["action"]
          end
        end
      end
        
      def define_baywatch(configuration)
        self.class_eval do
          define_method :baywatch do |exception|
            raise exception unless configuration.include? baywatch_requested_action
            block =  configuration[baywatch_requested_action]
            self.instance_eval &block
          end
        end
      end

        def register_rescue_from(exceptions)
          self.class_eval do 
            self.rescue_from *exceptions, :with => :baywatch
          end
        end
        

      end #classMethods

  end
end
