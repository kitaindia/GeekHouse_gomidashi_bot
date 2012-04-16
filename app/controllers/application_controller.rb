class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  before_filter :auth


  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      return
    end
  end

  def auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['USER'] && pass == ENV['PASS']
    end
  end

end
