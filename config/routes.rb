Rails.application.routes.draw do
  
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面
  root to: 'homes#top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'search_user' => 'users#search_user'                                 #ユーザー一覧のpath
  
  resources :direct_messages, only: [:create]                             #チャットのメッセージ
  resources :rooms, :only => [:create, :show, :index]
  
  
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resource :post_favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    
    resource :bookmarks, only: [:create, :destroy]
  end
  
  get '/boards/bookmarks' => "boards#bookmarks"
  
  get 'finder' => "finders#finder"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
