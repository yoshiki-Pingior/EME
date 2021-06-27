class BoardsController < ApplicationController
before_action :authenticate_user!

  def bookmarks
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id).search(params[:bookmarks])
  end
end
