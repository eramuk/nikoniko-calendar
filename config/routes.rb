Rails.application.routes.draw do
  root 'login#index'
  get 'signup' => 'users#new'
end
