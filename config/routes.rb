Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'events#index'

  resources :users,    only: [:new, :create, :show]
  resources :events,   only: [:new, :create, :show, :index]
  resources :sessions, only: [:new, :create]

  get '/logout', to: 'sessions#destroy'
end
