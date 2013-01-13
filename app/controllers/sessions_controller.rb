class SessionsController < ApplicationController

  def create
    if @auth = Authorization.from_omniauth(request.env['omniauth.auth'])
      self.current_user = @auth.user
      redirect_to root_url
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url
  end
end