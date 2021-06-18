class BoardsController < ApplicationController

  def bookmarks
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id).search(params[:bookmarks])
  end
end
