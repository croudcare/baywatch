class BeachesController < ApplicationController
  include Baywatch::Rescue
 
  service_down do |on|
    on.only :venice, :long_beach do 
      redirect_to "/baywatch_service_down_rescued"
    end
  end

  def long_beach
    redirect_to "beaches_venice"
  end

  def venice
    redirect_to "beaches_venice"
  end

  def sunset
    redirect_to "beaches_venice"
  end

end