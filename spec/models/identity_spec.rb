require 'spec_helper'

describe Identity do
  before(:each) do
    @auth = FactoryGirl.create(:identity)
  end

  describe "validations" do
    subject { @auth }
    describe "with missing provider" do
      before { @auth.provider = nil}
      it { should_not be_valid }
    end
    describe "with missing uid" do
      before { @auth.uid = nil}
      it { should_not be_valid }
    end
    describe "with missing user" do
      before { @auth.user = nil}
      it { should_not be_valid }
    end
  end

  describe "from omniauth" do
    include Omniauth
    describe "when identity already exists" do
      it "should return that identity without creating another one" do
        auth = nil
        expect do
          auth = Identity.from_omniauth('provider' => @auth.provider, 'uid' => @auth.uid)
        end.not_to change(Identity, :count)
        Identity.find_by(uid: @auth.uid, provider: @auth.provider).should == auth
      end
    end

    describe "when identity doesn't exist" do
      it "should create and return a new identity associated with the right user" do
        auth = nil
        user = FactoryGirl.create(:user)
        expect do
          auth = Identity.from_omniauth(auth_params(user.email))
        end.to change(Identity, :count).by(1)
        auth.provider.should == auth_params['provider']
        auth.uid.should      == auth_params['uid']
        auth.image.should    == auth_params['info']['image']
        auth.user.should     == user
      end
    end
  end
end

