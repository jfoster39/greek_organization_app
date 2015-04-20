class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  belongs_to :organization

  has_one :token

  has_many :announcements

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    credentials = access_token.credentials
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(
        first_name: data["first_name"],
        last_name: data["last_name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        role: "pending"
      )
    end
    unless !user.token.nil?
      Token.create(
        access_token: credentials["token"],
        refresh_token: credentials["refresh_token"],
        expires_at: credentials["expires_at"],
        user: user
      )
    end
    user
  end

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

  def documents
    [
      Document.new(
        "<i class='fa fa-question-circle'></i> Form",
        Date.yesterday,
        "Date Night Signup",
        "10kb"
      ),
      Document.new(
        "<i class='fa fa-folder'></i> Folder",
        Date.yesterday - 30,
        "Word",
        "0kb"
      ),
      Document.new(
        "<i class='fa fa-file-text '></i> Document",
        Date.yesterday - 2,
        "Exec 3.30.2015 Minutes",
        "42kb"
      ),
      Document.new(
        "<i class='fa fa-question-circle'></i> Form",
        Date.yesterday - 4,
        "Tug Signup",
        "8kb"
      ),
      Document.new(
        "<i class='fa fa-question-circle'></i> Form",
        Date.yesterday - 30,
        "Formal Signup",
        "16kb"
      )
    ]
  end

  class Document < Struct.new(:type, :updated_at, :name, :size)

  end

end
