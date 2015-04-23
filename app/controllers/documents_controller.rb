class DocumentsController < ApplicationController
  before_filter :ensure_admin_of_org, only: [:edit, :update, :destroy]
  before_filter :ensure_admin, only: [:new, :create]

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to organization_documents_path
    else
      render action: "new"
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.attributes = document_params
    if @document.save
      redirect_to edit_document_path, notice: "Document successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to organization_documents_path, notice: "Document successfully deleted"
  end

  private

  def document_params
    params.require(:document).permit(
      :title,
      :link
    ).merge(
      organization_id: current_user.organization.id,
      user_id: current_user.id
    )
  end

  def ensure_admin_of_org
    @document = Document.find(params[:id])
    unless current_user && current_user.is_admin_of(@document.organization)
      redirect_to user_dashboard_path, alert: "You do not have permission to perform this action."
    end
  end

  def ensure_admin
    unless current_user && current_user.is_admin?
      redirect_to user_dashboard_path, alert: "You do not have permission to perform this action."
    end
  end

end
