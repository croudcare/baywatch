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
    redirect_to "/baywatch_timeout"
  end

  def edit
    redirect_to "/baywatch_edit"
  end

end