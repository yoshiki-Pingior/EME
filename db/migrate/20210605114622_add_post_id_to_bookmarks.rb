class AddPostIdToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :post_id, :integer
  end
end
