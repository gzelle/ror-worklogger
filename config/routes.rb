Rails.application.routes.draw do
  root 'sessions#new'
  get 'sessions/new'
  get 'users/new'	
  
  get     '/users',   to: 'users#index'
  get     '/logs',    to: 'logs#index'
  get 		'/signup', 	to: 'users#new'
  get 		'/login', 	to: 'sessions#new'
  post 		'/login', 	to: 'sessions#create'
  delete	'/logout', 	to: 'sessions#destroy'

  resources :projects
  resources :logs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
