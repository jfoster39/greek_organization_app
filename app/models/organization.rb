class Organization < ActiveRecord::Base

  belongs_to :financial_provider

  has_many :users
  has_many :announcements

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

  def recent_announcements(limit=5)
    announcements.limit(limit)
  end

end
