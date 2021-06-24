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

  has_many :posts                                    #投稿機能
  attachment :image, destroy: false                  #画像投稿
  has_many :post_favorites, dependent: :destroy      #いいね機能
  has_many :post_comments, dependent: :destroy       #コメント機能
  has_many :bookmarks, dependent: :destroy           #お気に入り機能
  has_many :direct_messages, dependent: :destroy     #チャット機能
  has_many :entries, dependent: :destroy             #チャット機能
  has_many :rooms, through: :entries                 #チャット部屋
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy     #フォロワー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy                #フォロー機能
  has_many :followers, through: :reverse_of_relationships, source: :follower                                          #フォロワー機能
  has_many :followings, through: :relationships, source: :followed                                                    #フォロー機能

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_user(search_user)                            #user一覧での検索
    if search_user
      User.where(['last_name LIKE ? OR last_name_kana LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{search_user}%","%#{search_user}%","%#{search_user}%","%#{search_user}%"])
    else
      User.all
    end
  end

  def self.looks(words)                                        #検索一覧での検索
    @user = User.where(['last_name LIKE ? OR last_name_kana LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{words}%","%#{words}%","%#{words}%","%#{words}%"])
  end
  
  def self.guest                                               # ゲストユーザーでログインできるように設定
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64              # パスワードはランダム設定
      user.last_name = "てすと"
      user.first_name = "げすと"
      user.last_name_kana = "テスト"
      user.first_name_kana = "ゲスト"
    end
  end

end
