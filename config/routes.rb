Rails.application.routes.draw do
  get 'users/new'
  get '/signup', to: 'users#new'

  resources :projects
  resources :logs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
