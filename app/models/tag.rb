class Tag < ApplicationRecord
  before_save :downcase_tag_name
  
  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps
  
  validates :tag_name, presence: true
  
  private
  
    def downcase_tag_name
      self.tag_name.downcase!
    end
end
