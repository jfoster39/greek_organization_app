class UserCreateOrganizationForm
  include ActiveModel::Model

  attr_accessor :user_id, :name, :financial_provider_name, :financial_provider_url, :organization, :calendar_url

  def initialize(args={})
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.find(user_id)
  end

  def submit
    @financial_provider = FinancialProvider.where(
      name: financial_provider_name,
      external_url: financial_provider_url
    ).first_or_create
    @organization = Organization.new(
      name: name,
      financial_provider: @financial_provider,
    )
    @calendar = Calendar.new(
      embed_url: calendar_url,
      organization: @organization
    )
    ActiveRecord::Base.transaction do
      if !@organization.save
        @organization.errors.full_messages.each do |msg|
          errors.add(:organization, msg)
        end
        return false
      end
      if !@calendar.save
        @calendar.errors.full_messages.each do |msg|
          errors.add(:organization, msg)
        end
        return false
      end
      @user.organization = @organization
      @user.role = "admin"
      return @user.save
    end
  end

end
