Rails.application.routes.draw do
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :campaigns
  resources :users

  get '/signup', to: 'users#new'

  root 'campaigns#index'
end
