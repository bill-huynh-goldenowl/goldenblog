Rails.application.routes.draw do
  root to: 'homes#index'
  
  resources :posts
  resources :categories
  resources :posts do
    member do 
      post :approve
      post :disapprove
    end
  end

  get 'users/index'
  get 'users/show'
  get 'users/edit'

  
  get 'users/edit_password/:id' => 'users#edit_password', as: :edit_password
  post 'users/update_pwd/:id' => 'users#update_pwd', as: :update_pwd
  patch 'users/update/:id' => 'users#update', as: :update

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
