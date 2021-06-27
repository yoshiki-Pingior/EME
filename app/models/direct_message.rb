class DirectMessage < ApplicationRecord
  
  validates :message, presence: true, length: { maximum: 500 } 
  
  belongs_to :user
  belongs_to :room
end
