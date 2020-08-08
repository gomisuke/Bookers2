Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  get 'users' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#top'
  get 'home/about' => 'books#about'
  post 'follow/:id' => 'relationships#create', as:'follow'
  post 'unfollow/:id' => 'relationships#destory', as:'unfollow'
  get 'following/index/:id' => 'relationships#following_index', as:'following_index'
  get 'follower/index/:id' => 'relationships#follower_index', as: 'follower_index'
  get 'search' => 'searchs#search', as: 'search'
  resources :books, only:[:index, :create, :show, :edit, :update, :destroy] do
  	resource :favorites, only:[:create, :destroy]
  	resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only:[:show, :edit, :update]
end
