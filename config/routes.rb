Rails.application.routes.draw do
  resources :posts
  root to: 'pages#home'
  devise_for :users,
              # path: '',
              # path_names: {sign_in: 'login' ,sign_out: 'logout' ,edit: 'profile',sign_up: 'resgistration'},
              controllers: {
                omniauth_callbacks: 'omniauth_callbacks',
                # sessions: 'users/sessions'
              }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
