Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  
  resources :posts, only: [:index, :show, :new, :create, :destroy]


  get 'relationships/create'
  get 'relationships/destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
