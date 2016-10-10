class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_in(user)
  	session[:user_id] = user.id
  	user.create_remember_digest
  	cookies.permanent[:remember_digest] = user.remember_digest
  end

  def current_user
  	@current_user ||= User.find_by(remember_digest: cookies.permanent[:remember_digest]) 
  end

  def set_current_user(user)
  	@current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def sign_out
  	session[:user_id] = nil
  	cookies.permanent[:remember_digest].delete
  end
end
