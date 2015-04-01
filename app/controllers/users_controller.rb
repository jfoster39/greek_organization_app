class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  before_filter :ensure_authorized, only: [:edit, :update, :destroy]

  def dashboard
  end

  def new
    @organizations = Organization.all
    @user_form = UserForm.new
  end

  def create
    @organizations = Organization.all
    @user_form = UserForm.new(user_form_params)
    if @user_form.submit
      redirect_to new_user_session_path, notice: "Thank you. Your account must be confirmed by an admin of the organization before you can sign in."
    else
      render action: "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if @user.save
      redirect_to edit_user_path, notice: "User successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def approve
    @user = User.find(params[:id])
    @user.update(role: "member")
    redirect_to organization_users_path
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(
        :email,
        :phone_number,
        :first_name,
        :last_name
      )
    else
      params.require(:user).permit(
        :email,
        :phone_number,
        :first_name,
        :last_name,
        :password,
        :password_confirmation
      )
    end
  end

  def user_form_params
    params.require(:user_form).permit(
      :email,
      :password,
      :password_confirmation,
      :organization_id,
      :phone_number,
      :first_name,
      :last_name
    )
  end

  def ensure_authorized
    @user = User.find(params[:id])
    unless current_user.has_authorization_over(@user)
      redirect_to user_dashboard_path, alert: "You do not have authorization to perform this action."
    end
  end

end
