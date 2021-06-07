class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  attachment :image, destroy: false

  has_many :post_favorites, dependent: :destroy      #いいね機能
  has_many :post_comments, dependent: :destroy       #コメント機能

  has_many :bookmarks, dependent: :destroy           #お気に入り機能
  
  has_many :direct_messages, dependent: :destroy     #チャット機能
  has_many :entries, dependent: :destroy             #チャット機能

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
