class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  def is_admin?
    role == "admin"
  end

end
