class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @follow_users = @user.followings                                         #フォローしているユーザー情報取得のため追加
    @post = Post.all
  end

  def search_user
    @user = current_user
    @users = User.all
    @users = User.search_user(params[:search_user]).order(created_at: :desc) #ユーザー一覧から検索するために追加
    @users = @users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @post = Post.all.order(created_at: :desc).page(params[:page]).per(6)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id                                           #ログインユーザーならmsgを表示させる
      @msg ="他のユーザーをフォローしよう！"
    else
       @currentUserEntry.each do |cu|                                        #ログインユーザー以外の場合はチャット作成
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      if @isRoom != true
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != params[:id].to_i                                   #他のユーザーの編集画面に遷移できないように設定
      flash[:notice] = "アクセス権限がありません"
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

   private

  def user_params
     params.require(:user).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :hobby, :image, :introduction, :career, :interest_field, :holiday, :qualification, :free_space)
  end

end
