class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard

  end

  def index
      @users = User.all
  end

  def users
      @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

end
