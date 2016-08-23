Rails.application.routes.draw do
  resources :iprange, only: [:show] do
    resources :ipaddress, only: [:show]
  end

  root 'dashboard#index'
  get '/dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end
