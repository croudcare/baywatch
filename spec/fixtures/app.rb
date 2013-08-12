require 'active_model'
require 'active_support/all'
require 'action_controller'
require 'action_dispatch'

module Rails
  class App

    def env_config; {} end
    
    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
        
        get "/baywatch" => "baywatch#index"
        get "/timeout" => "baywatch#timeout"
        get "/edit" => "baywatch#edit"

        get "/long_beach" => "beaches#long_beach"
        get "/venice" => "beaches#venice"
        get "/sunset" => "beaches#sunset"
      end
   
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end
  
end