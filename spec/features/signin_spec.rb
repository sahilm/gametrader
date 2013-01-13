require 'spec_helper'

describe "Sign in", type: :feature do
  before(:each) do
    visit root_path
    click_link 'Sign in'
    click_link 'Facebook'
    if page.has_selector?('#login_form')
      within("#login_form") do
        fill_in 'email',    with: CONFIG[:facebook][:test_user][:email]
        fill_in 'pass',     with: CONFIG[:facebook][:test_user][:password]
        # login
        page.find('#u_0_1').click
      end
      # authorize app
      if page.has_selector?('#u_0_0')
        page.find('#u_0_0').click
      end
    end
  end

  describe "via Facebook", type: :feature do
    it "should let me sign in" do
      current_path.should == root_path
      page.should_not have_link 'Sign in'
      page.should have_selector ".avatar"
      page.should have_content CONFIG[:facebook][:test_user][:first_name]
      page.should have_selector ".icon-cog"
      page.click_link CONFIG[:facebook][:test_user][:first_name]
      page.should have_link "Sign out"
    end

    it "should let me sign out" do
      page.click_link CONFIG[:facebook][:test_user][:first_name]
      page.click_link 'Sign out'
      page.should have_link 'Sign in'
      page.should_not have_link CONFIG[:facebook][:test_user][:first_name]
      current_path.should == root_path
    end
  end
end