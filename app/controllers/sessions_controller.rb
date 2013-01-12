class SessionsController < ApplicationController

  def create
    if @auth = Authorization.from_omniauth(request.env['omniauth.auth'])
      self.current_auth = @auth
      redirect_to root_path
    end
  end
end