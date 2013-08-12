require 'spec_helper'

describe Baywatch do 

  context "Service Down Interface" do 
    before(:each) do 
      @controller = Class.new(ActionController::Base) do
                      include Baywatch::Rescue
                      service_down do |on| on.action {} end
                  end
    end

    it "pass Baywatch::Config as block parameter" do 
      @controller.service_down do |on|
        expect(on).to be_kind_of(Baywatch::Config)
      end
    end

    it "register baywatch method to instance" do
      expect(@controller.new).to respond_to(:baywatch) 
    end

    it "pass Baywatch::Config as block parameter" do
       @controller.service_down do |on|
        expect{ on.create }.to raise_error
      end
    end

  end
end  