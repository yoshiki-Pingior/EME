Rails.application.routes.draw do
  devise_for :users
  
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  get 'posts/create'
  get 'posts/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'homes/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
