class Tag < ApplicationRecord
  before_save :downcase_tag_name
  
  validates :tag_name, presence: true, length: { maximum: 100 } 
  
  has_many :tag_maps, dependent: :destroy
  has_many :posts, through: :tag_maps
  
  private
  
    def downcase_tag_name
      self.tag_name.downcase!
    end
end
