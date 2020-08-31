Rails.application.routes.draw do
  
  resources :posts
  resources :categories
  post '/posts/approve/:id' => 'posts#approve', as: :approve_posts
  post '/posts/disapprove/:id' => 'posts#disapprove', as: :disapprove_posts
  root to: 'homes#index'
  get 'users/edit'
  post 'users/update'

  devise_for :users
  # controllers: {
  #   omniauth_callbacks: 'omniauth_callbacks',
  #   # sessions: 'users/sessions'
  # }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
