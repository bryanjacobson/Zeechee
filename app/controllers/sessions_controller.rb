# Copyright 2012 Bryan Lee Jacobson
class SessionsController < ApplicationController
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      session[:edit_mode] = false
      redirect_to topics_path, :notice => "Logged in successfully"
    else
      redirect_to root_path, :notice => "Invalid login/password combination"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end

  def learn
    session[:edit_mode] = false
    redirect_to request.env["HTTP_REFERER"]
  end

  def edit
    session[:edit_mode] = true
    redirect_to request.env["HTTP_REFERER"]
  end
end
