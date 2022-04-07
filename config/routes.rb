Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'
  resources :users, only: :show
  resources :events, only: [:new, :create] do
    resources :events_hosts, only: :show
    get '/event_hosts/:id/info', to: "event_hosts#info"
  end
end
