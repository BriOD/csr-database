Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, skip: [:sessions], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
