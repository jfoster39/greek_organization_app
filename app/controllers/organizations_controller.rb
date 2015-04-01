class OrganizationsController < ApplicationController

  def new
    @organization_form = OrganizationForm.new
  end

  def create
    @organization_form = OrganizationForm.new(organization_form_params)
    if @organization_form.submit
      sign_in(:user, @organization_form.user)
      redirect_to root_path, notice: "Thank you for creating your organization!"
    else
      render action: "new"
    end
  end

  def users
    @users = current_organization.users.where.not(role: "pending")
    @pending_users = current_organization.pending_users
  end

  private

  def organization_form_params
    params.require(:organization_form).permit(
      :email,
      :password,
      :password_confirmation,
      :organization_name,
      :phone_number,
      :first_name,
      :last_name
    )
  end

end
