module Signin
  def assert_signed_in(page, user)
    page.should_not have_link 'Sign in'
    page.should have_success_message("Welcome, #{user[:first_name]}!")
    page.should have_content user[:first_name]
    page.should have_selector ".icon-cog"
    page.should have_selector ".avatar"
    page.click_link user[:first_name]
    page.should have_link "Sign out"
  end

  def sign_out(page, user)
    page.click_link user[:first_name]
    page.click_link 'Sign out'
    page.should have_link 'Sign in'
    page.should_not have_link user[:first_name]
    current_path.should == root_path
  end
end