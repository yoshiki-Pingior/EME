Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resource :post_favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    
    resource :bookmarks, only: [:create, :destroy]
  end
  get '/boards/bookmarks' => "boards#bookmarks"



  get 'relationships/create'
  get 'relationships/destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
