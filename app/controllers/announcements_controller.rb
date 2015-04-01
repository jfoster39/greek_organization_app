class AnnouncementsController < ApplicationController
  before_filter :ensure_admin_of_org, only: [:edit, :update, :destroy]
  before_filter :ensure_admin, only: [:new, :create]

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      redirect_to organization_announcements_path
    else
      render action: "new"
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    @announcement.attributes = announcement_params
    if @announcement.save
      redirect_to edit_announcement_path, notice: "Announcement successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to organization_announcements_path, notice: "Announcement successfully deleted"
  end

  private

  def announcement_params
    params.require(:announcement).permit(
      :title,
      :html_body,
      :plaintext_body
    ).merge(
      organization_id: current_user.organization.id,
      user_id: current_user.id
    )
  end

  def ensure_admin_of_org
    @announcement = Announcement.find(params[:id])
    if current_user
      if !current_user.is_admin_of(@announcement.organization)
        redirect_to user_dashboard_path, alert: "You do not have permission to perform this action."
      end
    end
  end

  def ensure_admin
    if current_user
      if !current_user.is_admin?
        redirect_to user_dashboard_path, alert: "You do not have permission to perform this action."
      end
    end
  end

end
