class UsersController < ApplicationController
  skip_before_filter :authenticate_user, only: [:new, :create, :edit_organization, :update_organization, :create_organization]
  before_filter :ensure_authorized, only: [:edit, :update, :destroy]

  def edit_organization
    @join_organization_form = UserJoinOrganizationForm.new(user_id: current_user.id)
    @create_organization_form = UserCreateOrganizationForm.new(user_id: current_user.id)
    @organizations = Organization.all
  end

  def create_organization
    @join_organization_form = UserJoinOrganizationForm.new(user_id: current_user.id)
    @organizations = Organization.all
    @create_organization_form = UserCreateOrganizationForm.new(create_org_params)
    if @create_organization_form.submit
      redirect_to root_path, notice: "Thank you for creating your organization."
    else
      render 'edit_organization'
    end
  end

  def update_organization
    @join_organization_form = UserJoinOrganizationForm.new(join_org_params)
    @organizations = Organization.all
    @create_organization_form = UserCreateOrganizationForm.new(user_id: current_user.id)
    if @join_organization_form.submit
      redirect_to new_user_session_path, notice: "Thank you. Your account must be confirmed by an admin of the organization before you can sign in."
    else
      render 'edit_organization'
    end
  end

  def dashboard
    @announcements = current_user.organization.recent_announcements
    @calendar = current_organization.calendar
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
    redirect_to organization_users_path, notice: "User successfully deleted"
  end

  def approve
    @user = User.find(params[:id])
    @user.update(role: "member")
    redirect_to organization_users_path
  end

  def documents
    @documents = current_user.documents
  end

  private

  def user_params
    if params[:user][:is_admin].to_i == 1
      params[:user][:role] = "admin"
    else
      params[:user][:role] = "member"
    end
    params[:user].delete :is_admin
    if params[:user][:password].blank? && current_user.is_admin?
      params.require(:user).permit(
        :email,
        :phone_number,
        :first_name,
        :last_name,
        :role
      )
    elsif params[:user][:password].blank?
      params.require(:user).permit(
        :email,
        :phone_number,
        :first_name,
        :last_name
      )
    elsif current_user.is_admin?
      params.require(:user).permit(
        :email,
        :phone_number,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :role
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

  def join_org_params
    params.require(:user_join_organization_form).permit(
      :id
    ).merge(user_id: current_user.id)
  end

  def create_org_params
    params.require(:user_create_organization_form).permit(
      :name,
      :financial_provider_name,
      :financial_provider_url,
      :calendar_url
    ).merge(user_id: current_user.id)
  end

  def ensure_authorized
    @user = User.find(params[:id])
    unless current_user && current_user.has_authorization_over(@user)
      redirect_to user_dashboard_path, alert: "You do not have authorization to perform this action."
    end
  end

end
