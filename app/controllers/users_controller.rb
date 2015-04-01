class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]

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

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  def approve
    @user = User.find(params[:id])
    @user.update(role: "member")
    redirect_to organization_users_path
  end

  private

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

end
