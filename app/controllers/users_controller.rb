class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard

  end

  def users
      @users = User.all
  end
  


end
