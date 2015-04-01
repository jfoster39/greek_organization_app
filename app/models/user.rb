class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  has_many :announcements

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  def full_name
    first_name + " " + last_name
  end

  def is_admin?
    role == "admin"
  end

  def is_admin_of(org)
    role == "admin" && self.organization == org
  end

  def has_authorization_over(user)
    self == user || (self.role == "admin" && self.organization == user.organization)
  end

end
