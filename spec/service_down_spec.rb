require 'spec_helper'

describe BaywatchController, type: :controller do

  context "Service Down Interface" do 
    it "pass Baywatch::Config as block parameter" do 
      WhateverController = Class.new(ActionController::Base) do
        include Baywatch::Rescue 
      end

      WhateverController.service_down do |on|
        expect(on).to be_kind_of(Baywatch::Config)
      end
    end

    it "register baywatch method to instance" do
      expect(controller).to respond_to(:baywatch) 
    end
  end  

  context "Service Unavailable Exceptions" do 
    
    it "capture Errno::ECONNRESET " do
      controller.stub(:index) do
        raise Errno::ECONNRESET.new
      end

      get :index
      response.should redirect_to("/baywatch_service_down_rescued")
    end

    it "capture Errno::ECONNREFUSED " do
      controller.stub(:index) do
        raise Errno::ECONNREFUSED.new
      end

      get :index
      response.should redirect_to("/baywatch_service_down_rescued")
    end

     it "capture Errno::ECONNREFUSED " do
       get :timeout
      response.should redirect_to("/baywatch_service_down_rescued")
    end

  end

end