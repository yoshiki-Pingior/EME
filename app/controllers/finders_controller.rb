class FindersController < ApplicationController
  def finder
      @users = User.looks(params[:word]).page(params[:page]).per(10)
      @posts = Post.looks(params[:word]).page(params[:page]).per(6)
      @bookmarks = Bookmark.looks(params[:word]).page(params[:page]).per(6)
      
  end
end



