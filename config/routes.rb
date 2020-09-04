Rails.application.routes.draw do
  
  resources :posts do
    resources :comments, module: :posts
  end

  # resources :discussion do
  #   resources :comments, module: :discussion
  # end

  resources :categories
  post '/posts/approve/:id' => 'posts#approve', as: :approve_posts
  post '/posts/disapprove/:id' => 'posts#disapprove', as: :disapprove_posts
  root to: 'homes#index'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/edit_password/:id' => 'users#edit_password', as: :edit_password
  post 'users/update_pwd/:id' => 'users#update_pwd', as: :update_pwd
  
  post 'users/update'
  patch 'users/update/:id' => 'users#update', as: :update

  devise_for :users
  # controllers: {
  #   omniauth_callbacks: 'omniauth_callbacks',
  #   # sessions: 'users/sessions'
  # }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
