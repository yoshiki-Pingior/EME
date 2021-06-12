class BoardsController < ApplicationController

  def bookmarks
    @bookmarks = Bookmark.where(user_id: current_user.id).search(params[:bookmarks])
  end
end
