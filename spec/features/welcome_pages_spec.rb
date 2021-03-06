require 'spec_helper'

describe "Welcome page" do
  before(:each) do
    visit root_path
  end

  describe "navbar" do
    describe "for a non-signed in user" do
      it "should have the correct links" do
        within(".navbar .navbar-inner .container") do
          page.should have_selector %Q{a.brand[href="#{root_path}"]}, text: 'GameTrader'
          page.should have_link 'Sign in'
          page.should have_selector '.icon-lock'
        end
      end

      it "should have sign in via facebook link" do
        within(".navbar .navbar-inner .container") do
          click_link 'Sign in'
          page.should have_link 'Facebook', href: "/auth/facebook?origin=#{root_path}"
          page.should have_selector '.icon-facebook-sign'
        end
      end

      it "should have sign in via google link" do
        within(".navbar .navbar-inner .container") do
          click_link 'Sign in'
          page.should have_link 'Google', href: "/auth/google_oauth2?origin=#{root_path}"
          page.should have_selector '.icon-google-plus-sign'
        end
      end
    end
  end

  describe "header" do
    it "fill in some tests"
  end
end
