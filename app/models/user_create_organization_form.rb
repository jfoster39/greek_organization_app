class UserCreateOrganizationForm
  include ActiveModel::Model

  attr_accessor :user_id, :name, :financial_provider_name, :financial_provider_url, :organization

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
    if @organization.save
      @user.organization = @organization
      @user.role = "admin"
      return @user.save
    else
      return false
    end
  end

end
