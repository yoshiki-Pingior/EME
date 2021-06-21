class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.all
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page]).per(6)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tag_list = tag_params[:tag_name].split(/[[:blank:]]+/).select(&:present?)   #追加
      @post.save_tags(tag_list)
      redirect_to posts_path
    else
      render 'new'
      
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_title, :post_text, :post_free_space, :image, :user_id)
  end

  def tag_params       #追加
    params.require(:post).permit(:tag_name)
  end
end
