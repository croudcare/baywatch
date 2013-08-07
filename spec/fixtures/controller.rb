class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  def render(*attributes); end
end

class BaywatchController < ApplicationController
  include Baywatch::Rescue

  class TimeoutException < StandardError; end

  service_down(BaywatchController::TimeoutException) do |on|
    
    on.index do |e|
      redirect_to "/baywatch_service_down_rescued"
    end

    on.timeout do |e|
      redirect_to "/baywatch_service_down_rescued"
    end

  end

  def index
    redirect_to "/baywatch_index"
   end

  def timeout
    raise TimeoutException.new
  end

end