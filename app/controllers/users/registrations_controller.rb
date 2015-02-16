class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @organizations = Organization.all
    super
  end

end
