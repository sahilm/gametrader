require 'spec_helper'

describe "Sign in", type: :feature do

  describe "via Facebook", type: :feature do
    before { visit root_path }
    it "should let me sign in" do
      within(".navbar .navbar-inner .container") do
        click_link 'Sign in via'
        click_link 'Facebook'
      end
      within("#login_form") do
        fill_in 'email',    with: CONFIG[:facebook][:test_user_email]
        fill_in 'pass',     with: CONFIG[:facebook][:test_user_pass]
        # login
        page.find('#u_0_1').click
      end
      # authorize app
      if page.has_selector?('#u_0_0')
        page.find('#u_0_0').click
      end
      current_path.should == root_path
      page.should_not have_link 'Sign in via'
      page.should have_selector "img.avatar"
    end
  end
end