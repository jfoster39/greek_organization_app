class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates :title, presence: true

end
