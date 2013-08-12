require 'spec_helper'

describe BeachesController, type: :controller do

  it "captures Errno::ECONNRESET " do
      controller.stub(:long_beach) do
        raise Errno::ECONNRESET.new
      end

      get :long_beach
      response.should redirect_to("/baywatch_service_down_rescued")
  end

  it "captures Errno::ECONNREFUSED " do
      controller.stub(:venice) do
        raise Errno::ECONNREFUSED.new
      end

      get :venice
      response.should redirect_to("/baywatch_service_down_rescued")
  end

  it "captures Errno::ECONNRESET " do
    exception = Errno::ECONNRESET.new
    controller.stub(:sunset) do
      raise exception
    end

    expect{ get :sunset }.to raise_error(exception)
  end

end
