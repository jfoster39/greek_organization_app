class UserJoinOrganizationForm
  include ActiveModel::Model

  attr_accessor :id, :user_id

  def initialize(args={})
    puts args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @user = User.find(user_id)
  end

  def submit
    if id.blank?
      self.errors.add(:base, "An organization must be selected")
      return false
    else
      @organization = Organization.find(id)
      @user.organization = @organization
      @user.save
    end
  end

end
