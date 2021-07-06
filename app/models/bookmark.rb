class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  def self.search(search)                                #お気に入り一覧での検索
    return all if search.blank?
      joins(post: :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
  end

  def self.title_or_text_or_name_like(words)                                  #検索一覧での検索
    joins(post: :user).where(['post_title LIKE ? OR post_text LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{words}%","%#{words}%","%#{words}%","%#{words}%"])
  end

end
