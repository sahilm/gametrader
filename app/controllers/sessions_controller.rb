class SessionsController < ApplicationController

  def create
    if auth = Identity.from_omniauth(request.env['omniauth.auth'])
      self.current_user = auth.user
      flash[:success] = "Welcome, #{auth.user.first_name}!"
    end
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def failure
    flash[:error] = "Unable to sign in. Did you remember to allow us access?"
    redirect_to root_path
  end

  def destroy
    self.current_user = nil
    flash[:notice] = "Signed out"
    redirect_to root_path
  end
end