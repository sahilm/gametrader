require 'spec_helper'

describe "Google sign in" do
  include Signin
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
    sign_out(page, @user)
  end
end
