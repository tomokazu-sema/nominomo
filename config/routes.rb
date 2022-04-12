Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'
  resources :users, only: :show
  resources :events, only: %i[new create show] do
    resources :hosts, only: :show
    get '/hosts/:id/info', to: 'hosts#info'
  end
end
