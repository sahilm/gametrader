class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :signed_in?, :current_user

  def current_user=(user)
    @current_user = user
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
  end
end
