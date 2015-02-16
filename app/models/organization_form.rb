class OrganizationForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :organization_name, :organization, :user

  def initialize(args={})
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.new
  end

  def submit
    @organization = Organization.new(name: @organization_name)
    @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      phone_number: @phone_number,
      password: @password,
      password_confirmation: @password_confirmation,
      organization: @organization,
      role: "admin"
    )
    ActiveRecord::Base.transaction do
      if !@user.save
        @user.errors.full_messages.each do |msg|
          errors.add(:user, msg)
        end
      end
      if !@organization.save
        @organization.errors.full_messages.each do |msg|
          errors.add(:organization, msg)
        end
      end
    end
    return errors.empty?
  end

end
