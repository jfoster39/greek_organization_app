class Organization < ActiveRecord::Base

  belongs_to :financial_provider

  has_many :users

  validates :name, presence: true

  def has_financial_provider?
    !financial_provider.nil?
  end

  def has_pending_members?
    !users.where(role: "pending").blank?
  end

  def pending_users
    users.where(role: "pending")
  end

end
