Rails.application.routes.draw do

	get '/login', to: "sessions#new"
	post '/login', to: "sessions#create"
	get '/logout', to: "sessions#destroy"
  get '/timeline', to: "users#timeline"
  get '/mentions', to: 'users#mentions'

  resources :users, only: [:index, :new, :create] do
    member do
      post 'follow'
    end
  end
  resources :statuses, only: [ :new, :create]

  get "/:username", to: "users#show", as: 'user'

  root to: "users#index"
end
