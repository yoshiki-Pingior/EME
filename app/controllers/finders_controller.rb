class FindersController < ApplicationController
  before_action :authenticate_user!

  def finder
    @users = User.looks(params[:word]).page(params[:page]).per(10)
    @users = @users.order(created_at: :desc).page(params[:page]).without_count.per(10)
    @posts = Post.looks(params[:word]).order(created_at: :desc)
    @posts = @posts.page(params[:page]).without_count.per(6)
    @bookmarks = Bookmark.where(user_id: current_user.id).looks(params[:word]).page(params[:page]).per(6).order(post_id: :desc)
  end
end



