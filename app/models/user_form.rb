class UserForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :organization_id, :organization, :user

  def initialize(args={})
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.new
  end

  def submit
    @organization = Organization.find_by_id(@organization_id.to_i)
    @user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      phone_number: @phone_number,
      password: @password,
      password_confirmation: @password_confirmation,
      organization: @organization,
      role: "pending"
    )
    if @organization.nil?
      @user.errors.add(:organization, "cannot be blank")
      return false
    else
      @user.save
    end
  end

end
