require 'spec_helper'

describe Authorization do
  before(:each) do
    @auth = FactoryGirl.create(:authorization)
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
    describe "with missing image" do
      before { @auth.image = nil }
      it { should_not be_valid }
    end
  end

  describe "from omniauth" do

    describe "when authorization already exists" do
      before(:each) do
        @auth = FactoryGirl.create(:authorization)
      end
      it "should return it without creating another one" do
        auth = nil
        expect do
          auth = Authorization.from_omniauth('provider' => @auth.provider, 'uid' => @auth.uid)
        end.not_to change(Authorization, :count)
        auth.should == Authorization.find_by(uid: @auth.uid, provider: @auth.provider)
      end
    end

    describe "when authorization doesn't exist" do

      describe "when no user by email exists" do
        it "should create a new authorization" do
          auth = nil
          expect do
            auth = Authorization.from_omniauth(auth_params)
          end.to change(Authorization, :count).by(1)
          auth.provider.should == auth_params['provider']
          auth.uid.should      == auth_params['uid']
          auth.image.should    == auth_params['info']['image']
        end

        it "should create a new user with associated authorization" do
          user = nil
          expect do
            user = Authorization.from_omniauth(auth_params).user
          end.to change(User, :count).by(1)
          user.email.should == auth_params['info']['email']
          user.first_name.should == auth_params['info']['first_name']
          user.last_name.should == auth_params['info']['last_name']
          user.authorizations.count.should == 1
          user.authorizations.first.should == Authorization.find_by(uid: auth_params['uid'])
        end
      end

      describe "when a user already exists" do
        before(:each) do
          @user = FactoryGirl.create(:user)
        end

        it "should create a new authorization and associate with user" do
          @user.authorizations.count.should == 0
          auth = nil
          expect do
            auth = Authorization.from_omniauth(auth_params(@user.email))
          end.to change(Authorization, :count).by(1)
          auth.provider.should == auth_params['provider']
          auth.uid.should      == auth_params['uid']
          auth.image.should    == auth_params['info']['image']
          @user.authorizations.count.should == 1
          @user.authorizations.first.should == Authorization.find_by(uid: auth_params['uid'])
        end

        it "should not create a new user" do
          expect do
            Authorization.from_omniauth(auth_params(@user.email)).user
          end.not_to change(User, :count)
        end
      end
    end
  end

  private
  def auth_params(email=nil)
    { 'provider' => 'Facebook',
      'uid' => '123',
      'info' =>
      {
        'email'      => email || 'foobar@example.org',
        'image'      => 'http://example.com/image',
        'first_name' => 'foo',
        'last_name'  => 'bar'
      }
    }
  end
end

