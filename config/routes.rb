Rails.application.routes.draw do
  
  root to: 'homes#index'
  get 'users/edit'
  patch 'users/update'

  devise_for :users
  # controllers: {
  #   omniauth_callbacks: 'omniauth_callbacks',
  #   # sessions: 'users/sessions'
  # }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
