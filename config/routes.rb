Gametrader::Application.routes.draw do
  root to: 'welcome#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'sessions#failure'
  delete 'signout', to: 'sessions#destroy', as: :signout
  resources :games, only: [:new, :create]
  namespace :api do
    resources :games, only: [:index]
  end
end
