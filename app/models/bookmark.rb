class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  def self.search(search)                                #お気に入り一覧での検索
    if Bookmark
      Bookmark.joins(post: :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
    else
      Bookmark.all
    end
  end

  def self.looks(words)                                  #検索一覧での検索
    @bookmark = Bookmark.joins(post: :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{words}%","%#{words}%","%#{words}%","%#{words}%"])
  end

end
