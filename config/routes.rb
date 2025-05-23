Rails.application.routes.draw do
   get '/current_user', to: 'current_user#index'
   devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  
  namespace :api do
    namespace :v1 do
      resources :startups,only: [:index, :show, :create, :update, :destroy] do
        resources :upvotes, only: [:create, :destroy]
        get "upvotes", to: "upvotes#show"
        resources :comments, only: [:create, :destroy]
      end
    end
  end

  get "/trendingstartups", to: 'api/v1/startups#trendingStartups'
  get "/mystartups/:user_id", to: 'api/v1/startups#myStartupsInformation'
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
