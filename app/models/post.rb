class Post < ApplicationRecord
  
  belongs_to :user
  attachment :image, destroy: false
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  
  def favorited_by?(user)
    post_favorites.where(user_id: user.id).exists?
  end
  
  has_many :bookmarks, dependent: :destroy
  
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
