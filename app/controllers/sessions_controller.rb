class SessionsController < ApplicationController
  require 'digest/sha1'
  attr_accessor :remember_token

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		sign_in(user)
  		set_current_user(user)
  	else
  		flash[:danger] = "Invalid email/password"
  		render 'new'
  	end
  end

  def delete
  	sign_out
  end


end
