require 'spec_helper'

describe User do

  it "should downcase emails before saving" do
    user = FactoryGirl.create(:user, email: 'FOOBAR@example.org')
    user.email.should == 'foobar@example.org'
  end

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
  end
end
