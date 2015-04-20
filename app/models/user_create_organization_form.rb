class UserCreateOrganizationForm
  include ActiveModel::Model

  attr_accessor :user_id, :name, :financial_provider_name, :financial_provider_url

  def initialize(args={})
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.find(user_id)
  end

  def submit
    @organization = Organization.new(
      name: name,
      financial_provider_name: financial_provider_name,
      financial_provider_url: financial_provider_url
    )
    if @organization.save
      @user.organization = @organization
      return @user.save
    else
      return false
    end
  end

end
