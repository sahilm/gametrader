class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_auth
    @current_auth ||= Authorization.find_by_id(session[:auth_id])
  end

  def signed_in?
    !!current_auth
  end

  helper_method :current_auth, :signed_in?

  def current_auth=(auth)
    @current_auth = auth
    session[:auth_id] = auth.id
  end
end
