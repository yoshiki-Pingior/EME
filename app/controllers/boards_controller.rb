class BoardsController < ApplicationController
before_action :authenticate_user!

  def bookmarks
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id).search(params[:bookmarks]).order(post_id: :desc)
    @bookmarks = @bookmarks.page(params[:page]).without_count.per(6)
  end
end
