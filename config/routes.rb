Gametrader::Application.routes.draw do
  root to: 'welcome#index'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/failure', to: 'sessions#failure'
  delete 'signout', to: 'sessions#destroy', as: :signout
end
