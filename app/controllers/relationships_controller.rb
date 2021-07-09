class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow(current_user)
    # redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    # redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.order(created_at: :desc).page(params[:page]).without_count.per(15)
    @user = current_user
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.order(created_at: :desc).page(params[:page]).without_count.per(15)
    @user = current_user
  end
end
