require 'spec_helper'

describe "Welcome page", type: :feature do
  before { visit root_path }

  describe "navbar", type: :feature do
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
          page.should have_link 'Facebook', href: '/auth/facebook'
          page.should have_selector '.icon-facebook-sign'
        end
      end

      it "should have sign in via google link" do
        within(".navbar .navbar-inner .container") do
          click_link 'Sign in'
          page.should have_link 'Google', href: '/auth/google_oauth2'
          page.should have_selector '.icon-google-plus-sign'
        end
      end
    end
  end
end
