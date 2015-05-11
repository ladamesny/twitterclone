Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'registrations' }
  get '/timeline', to: "users#timeline"
  get '/mentions', to: 'users#mentions'

  resources :users, only: [:index, :new, :create] do
    member do
      post 'follow'
    end
  end
  resources :statuses, only: [ :new, :create]
  root to: "users#index"
end
