class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true, length: { in: 1..20 }
  validates :first_name, presence: true, length: { in: 1..20 }
  validates :last_name_kana, presence: true, length: { in: 1..20 }
  validates :first_name_kana, presence: true, length: { in: 1..20 }
  validates :introduction, length: { maximum: 300 }
  validates :career, length: { maximum: 400 }
  validates :hobby, length: { maximum: 200 }
  validates :interest_field, length: { maximum: 200 }
  validates :holiday, length: { maximum: 300 }
  validates :qualification, length: { maximum: 200 }
  validates :free_space, length: { maximum: 500 }

  has_many :posts
  attachment :image, destroy: false

  has_many :post_favorites, dependent: :destroy      #いいね機能
  has_many :post_comments, dependent: :destroy       #コメント機能

  has_many :bookmarks, dependent: :destroy           #お気に入り機能

  has_many :direct_messages, dependent: :destroy     #チャット機能
  has_many :entries, dependent: :destroy             #チャット機能
  has_many :rooms, through: :entries

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

  def self.search_user(search_user) #self.はUser.を意味する
    if search_user
      User.where(['last_name LIKE ? OR last_name_kana LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{search_user}%","%#{search_user}%","%#{search_user}%","%#{search_user}%"])
    else
      User.all
    end
  end

  def self.looks(words)
    @user = User.where(['last_name LIKE ? OR last_name_kana LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{words}%","%#{words}%","%#{words}%","%#{words}%"])
  end
  
  # ゲストユーザーでログインできるように設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64  　          # パスワードはランダム設定
      user.last_name = "てすと"
      user.first_name = "げすと"
      user.last_name_kana = "テスト"
      user.first_name_kana = "ゲスト"
    end
  end

end
