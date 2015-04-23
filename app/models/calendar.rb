class Calendar < ActiveRecord::Base
  belongs_to :organization

  validates :embed_url, presence: true

end
