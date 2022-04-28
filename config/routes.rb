Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'
  resources :users, only: :show
  resources :events, only: %i[new create show update destroy] do
    resources :hosts, only: :show
    get '/hosts/:id/info', to: 'hosts#info'
    resources :event_places, only: %i[create update]
    resources :possible_dates, only: %i[create update]
  end
  get  '/events/:id/sign_in', to: 'events#new_guest'
  post '/events/:id/sign_in', to: 'events#create_guest'
end
