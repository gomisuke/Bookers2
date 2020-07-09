Rails.application.routes.draw do
  devise_for :users
  get 'users' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#top'
  get 'home/about' => 'books#about'
  resources :books, only:[:index, :create, :show, :edit, :update, :destroy]
  resources :users, only:[:show, :edit, :update]
end
