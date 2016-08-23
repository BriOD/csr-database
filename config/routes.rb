Rails.application.routes.draw do
  resources :ip_range, only: [:show] do
    resources :ip_address, only: [:show]
  end

  root 'dashboard#index'
  get '/dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end
