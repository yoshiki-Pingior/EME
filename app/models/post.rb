class Post < ApplicationRecord
  
  attachment :image, destroy: false
end
