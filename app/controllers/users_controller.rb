class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @users = User.all     #追加
    @post = Post.all
  end

  def search_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

   private

  def user_params
     params.require(:user).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :hobby, :image, :introduction, :career, :interest_field, :holiday, :qualification, :free_space)
  end
end
