require 'spec_helper'

describe User do
  describe "validations" do
    before { @user = FactoryGirl.build(:user) }
    subject { @user }

    describe "with missing email" do
      before { @user.email = nil }
      it { should_not be_valid }
    end

    describe "with duplicate email" do
      before(:each) do
        @other_user = FactoryGirl.create(:user)
        @user.email = @other_user.email
      end
      it { should_not be_valid }
    end

    describe "with duplicate email (ignoring case)" do
      before(:each) do
        @other_user = FactoryGirl.create(:user)
        @user.email = @other_user.email.upcase
      end
      it { should_not be_valid }
    end

    describe "with empty first name" do
      before { @user.first_name = nil}
      it { should_not be_valid }
    end
  end

  it "should downcase emails before saving" do
    user = FactoryGirl.create(:user, email: 'FOOBAR@example.org')
    user.email.should == 'foobar@example.org'
  end

  it "should return the users avatar" do
    user = FactoryGirl.create(:user)
    2.times { FactoryGirl.create(:authorization, user: user) }
    user.avatar.should == Authorization.where(user: user).first.image
  end

  describe "from omniauth" do
    include Omniauth
    describe "when a user with email exists" do
      before(:each) do
        @user = FactoryGirl.create(:user)
      end
      it "should return that user without creating another one" do
        user = nil
        expect do
          user = User.from_omniauth(auth_params(@user.email))
        end.not_to change(User, :count)
        User.find_by(email: @user.email).should == user
      end
    end
    describe "when a user with email doesn't exist" do
      it "should create and return a new user" do
        user = nil
        expect do
          user = User.from_omniauth(auth_params('foo@bar.com'))
        end.to change(User, :count).by(1)
        User.find_by(email: 'foo@bar.com').should == user
      end
    end
  end
end
