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

  has_many :notifications, dependent: :destroy        #通知機能

  def create_notification_like!(current_user)
    #すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      #自分の投稿に対するいいねの場合は通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checkd = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_post_comment!(current_user, post_comment_id)
    #自分以外にコメントしている人をすべて取得し、全員に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id)
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    #コメントは複数回することが考えられるため。一つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
      )
      #自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checkd = true
      end
      notification.save if notification.valid?
  end


  def self.search(search)                              #post一覧での検索
    return all if search.blank?
      joins(:tags).where(['post_title LIKE ? OR post_text LIKE ? OR tag_name LIKE?', "%#{search}%","%#{search}%","%#{search}%"])
  end

  def self.title_or_text_or_tag_like(words)                             #検索一覧での検索
    joins(:tags).where(['post_title LIKE ? OR post_text LIKE ? OR tag_name LIKE?', "%#{words}%","%#{words}%","%#{words}%"])
  end

end
