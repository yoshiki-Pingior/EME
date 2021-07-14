class PostFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.post_favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.post_favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

end
