require 'spec_helper'

describe "Sign in", type: :feature do
  describe "via Facebook", type: :feature do
    before(:each) do
      @user = CONFIG[:facebook][:test_user]
      visit root_path
      click_link 'Sign in'
      click_link 'Facebook'
      if page.has_selector?('#login_form')
        within("#login_form") do
          fill_in 'email',    with: @user[:email]
          fill_in 'pass',     with: @user[:password]
          # login
          page.find('#u_0_1').click
        end
        # authorize app
        if page.has_selector?('#u_0_0')
          page.find('#u_0_0').click
        end
      end
    end
    it "should let me sign in" do
      assert_signed_in(page, @user)
    end

    it "should let me sign out" do
      assert_signed_out(page, @user)
    end
  end

  describe "via Google" do
    before(:each) do
      @user = CONFIG[:google][:test_user]
      visit root_path
      click_link 'Sign in'
      click_link 'Google'
      if page.has_selector?('#gaia_loginform')
        within("#gaia_loginform") do
          fill_in 'Email',      with: @user[:email]
          fill_in 'Passwd',     with: @user[:password]
          page.find('#signIn').click
        end
        # authorize app
        if page.has_selector?('#submit_approve_access')
          sleep 1
          page.find('#submit_approve_access').click
        end
      end
    end
    
    it "should let me sign in" do
      assert_signed_in(page, @user)
    end

    it "should let me sign out" do
      assert_signed_out(page, @user)
    end
  end

  private
  
  def assert_signed_in(page, user)
    current_path.should == root_path
    page.should_not have_link 'Sign in'
    page.should have_selector ".avatar"
    page.should have_content user[:first_name]
    page.should have_selector ".icon-cog"
    page.click_link user[:first_name]
    page.should have_link "Sign out"
  end
  
  def assert_signed_out(page, user)
    page.click_link user[:first_name]
    page.click_link 'Sign out'
    page.should have_link 'Sign in'
    page.should_not have_link user[:first_name]
    current_path.should == root_path
  end
end