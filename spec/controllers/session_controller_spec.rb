require 'spec_helper'

describe SessionsController do
  describe "GET failure" do
    it "shows the right status" do
      get :failure
      flash[:error].should == "Unable to sign in. Did you remember to allow us access?"
      response.should redirect_to(root_path)
    end
  end
end