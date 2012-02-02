# Copyright 2012 Bryan Lee Jacobson
class HomeController < ApplicationController
  def index
    # Create a "new" user object for registration form
    @user = User.new
    @user_errors = notice
    @topics = Topic.roots
  end

  def tos
  end
end
