class Organization < ActiveRecord::Base

  belongs_to :financial_provider

  has_many :users

  validates :name, presence: true

  def has_financial_provider?
    return !financial_provider.nil?
  end

end
