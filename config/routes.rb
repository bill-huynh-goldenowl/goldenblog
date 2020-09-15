Rails.application.routes.draw do
  root to: 'homes#index'
  
  resources :posts do
    member do 
      post :approve
      post :reject
    end
    resources :comments, module: :posts
  end

  resources :categories

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
