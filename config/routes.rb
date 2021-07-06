Rails.application.routes.draw do

  get   'inquiry'         => 'inquiry#index'                              # 問い合わせ入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'                            # 問い合わせ確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'                             # 問い合わせ送信完了画面
  root to: 'homes#top'

  devise_for :users, controllers: {                                       # 問い合わせのpath
    registrations: "users/registrations",
    passwords: 'users/passwords'
  }
  
  devise_scope :user do                                                   # ゲストログインできるように設定
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :users, only: [:index, :show, :edit, :update] do              # userのpath
    resource :relationships, only: [:create, :destroy]                    # フォロー、フォロワーのpath
    get 'followings' => 'relationships#followings', as: 'followings'      # フォローのpath
    get 'followers' => 'relationships#followers', as: 'followers'         # フォロワーのpath
  end
  get 'search_user' => 'users#search_user'                                # ユーザー一覧のpath

  resources :direct_messages, only: [:create]                             # チャットメッセージのpath
  resources :rooms, :only => [:create, :show, :index]                     # チャット部屋のpath

  resources :posts, only: [:index, :show, :new, :create, :destroy] do     # 投稿のpath
    resource :post_favorites, only: [:create, :destroy]                   # いいねのpath
    resources :post_comments, only: [:create, :destroy]                   # コメントpath
    resource :bookmarks, only: [:create, :destroy]                        # お気に入りのpath
  end

  get '/boards/bookmarks' => "boards#bookmarks"                           # お気に入り一覧のpath
  get 'finder' => "finders#finder"                                        # 検索のルーティング
  
  resources :notifications, only: :index                                  # 通知のpath
  delete 'notifications/destroy_all' => 'notifications#destroy_all', as: 'notification_all_delete'  #通知削除のpath
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
