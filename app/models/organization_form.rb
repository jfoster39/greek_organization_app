class OrganizationForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :organization_name, :organization, :user, :financial_provider_name, :financial_provider_url, :calendar_url

  def initialize(args={})
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.new
  end

  def submit
    @financial_provider = FinancialProvider.where(name: @financial_provider_name, external_url: @financial_provider_url).first_or_create
    @organization = Organization.new(name: @organization_name, financial_provider: @financial_provider)
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
    @calendar = Calendar.new(
      embed_url: @calendar_url,
      organization: @organization
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
      if !@calendar.save
        @calendar.errors.full_messages.each do |msg|
          errors.add(:organization, msg)
        end
      end
    end
    return errors.empty?
  end

end
