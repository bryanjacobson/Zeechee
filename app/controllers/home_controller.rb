class HomeController < ApplicationController
  def index
    # Create a "new" user object for registration form
    @user = User.new
    @user_errors = notice
  end

end
