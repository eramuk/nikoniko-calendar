Rails.application.routes.draw do
  root 'login#index'

  get  'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :moods,               only: [:create, :update]
  resources :team_invitations
  resources :user_teams,          only: [:destroy]

  resources :teams do
    get 'join', on: :collection
    post 'leave', on: :member
    post 'banish', on: :member
  end
end
