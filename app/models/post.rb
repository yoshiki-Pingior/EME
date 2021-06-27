class Post < ApplicationRecord
  
  validates :post_title, presence: true, length: { in: 1..100 }
  validates :post_text, presence: true, length: { in: 1..1000 }
  validates :post_free_space, length: { maximum: 500 }

  belongs_to :user
  attachment :image, destroy: false
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy        #いいね機能

  def favorited_by?(user)
    post_favorites.where(user_id: user.id).exists?
  end

  has_many :bookmarks, dependent: :destroy            #お気に入り

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps                  #タグ

  def save_tags(tag_list)
    tag_list.each do |tag|

      unless find_tag = Tag.find_by(tag_name: tag.downcase)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
        TagMap.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end

  def self.search(search)                              #post一覧での検索
    if search
      Post.joins(:tags).where(['post_title LIKE ? OR post_text LIKE ? OR tag_name LIKE?', "%#{search}%","%#{search}%","%#{search}%"])
    else
      Post.all
    end
  end

  def self.looks(words)                             #検索一覧での検索
    @post = Post.joins(:tags).where(['post_title LIKE ? OR post_text LIKE ? OR tag_name LIKE?', "%#{words}%","%#{words}%","%#{words}%"])
  end

end
