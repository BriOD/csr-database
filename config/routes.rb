Rails.application.routes.draw do
  resources :iprange, only: [:show]

  root 'dashboard#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end
