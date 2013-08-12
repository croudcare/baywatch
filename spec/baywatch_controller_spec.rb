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

    it "captures Errno::ECONNRESET " do
      controller.stub(:index) do
        raise Errno::ECONNRESET.new
      end

      get :index
      response.should redirect_to("/baywatch_service_down_rescued")
    end

    it "captures Errno::ECONNREFUSED " do
      controller.stub(:index) do
        raise Errno::ECONNREFUSED.new
      end
      get :index
      response.should redirect_to("/baywatch_service_down_rescued")
    end

    it "doesn't capture unregistered exception" do 
      controller.stub(:index) do
        raise "WHATEVER EXCEPTION"
      end

      expect{ get :index }.to raise_error
    end

    it "does not capture exception for not registered action" do 
      controller.stub(:edit) do
        raise "WHATEVER EXCEPTION"
      end

      expect{ get :edit }.to raise_error("WHATEVER EXCEPTION")
    end

    it "captures explicit exception registered" do 
      controller.stub(:timeout) do
        raise BaywatchController::TimeoutException
      end

      get :timeout
      response.should redirect_to("/baywatch_service_down_rescued")
    end
  end
end