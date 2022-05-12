Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'
  resources :users, only: :show
  resources :events, only: %i[new create show edit update destroy] do
    resources :hosts, only: :show
    get '/hosts/:id/info', to: 'hosts#info'
    resources :places, only: %i[new create edit update]
    resources :possible_dates, only: %i[new create destroy] do
      resources :event_dates, only: %i[create destroy]
    end
    resources :guests, only: %i[new create edit update destroy]
    resources :notices, only: %i[new create edit update]
    resources :questions, only: %i[new create edit update destroy] do
      resources :question_answers, only: %i[new create edit update]
    end
    resources :payment_managements, only: %i[create destroy] do
      resources :payments, only: %i[new create edit update]
    end
  end
  get  '/events/:id/sign_in', to: 'events#new_guest'
  post '/events/:id/sign_in', to: 'events#create_guest'
end
