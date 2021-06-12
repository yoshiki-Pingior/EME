class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  def self.search(search)
    if Bookmark
      # Bookmark.joins(:post, :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ?', "%#{search}%","%#{search}%","%#{search}%"])
      Bookmark.joins(post: :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
    else
      Bookmark.all
    end
  end

end
