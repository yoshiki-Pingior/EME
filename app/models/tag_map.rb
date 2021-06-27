class TagMap < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  validates :tag_id, presence: true
end
