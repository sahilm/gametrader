require 'spec_helper'

describe "Welcome page", type: :feature do
  before { visit root_path }

  describe "navbar", type: :feature do
    it "should have the correct links" do
      within(".navbar .navbar-inner .container") do
        page.should have_selector %Q{a.brand[href="#{root_path}"]}, text: 'GameTrader'
        page.should have_link 'Sign in via'
      end
    end

    it "should have sign in via facebook link" do
      within(".navbar .navbar-inner .container") do
        click_link 'Sign in via'
        page.should have_link 'Facebook', href: '/auth/facebook'
      end
    end
  end
end
