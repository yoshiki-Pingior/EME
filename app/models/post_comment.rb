class PostComment < ApplicationRecord

  validates :comment,presence: true, length: { maximum: 150 }

  belongs_to :user
  belongs_to :post
  
  has_many :notifications, dependent: :destroy    #通知機能
end
