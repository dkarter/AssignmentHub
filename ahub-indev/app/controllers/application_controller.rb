class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:name]) if session[:name]
  end
end
