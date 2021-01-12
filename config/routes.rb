Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'events#index'

  resources :users,    only: [:new, :create, :show]
  resources :sessions, only: [:new, :create]
  resources :events,   only: [:new, :create, :show, :index] do
    resources :invitations, only: [:new, :create, :destroy]
  end

  get '/logout', to: 'sessions#destroy'
end
