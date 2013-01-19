require 'spec_helper'

describe "Facebook sign in" do
  include Signin
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
    sign_out(page, @user)
  end
end
