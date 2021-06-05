class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :image, destroy: false
  
  has_many :post_favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_many :bookmarks, dependent: :destroy

end
