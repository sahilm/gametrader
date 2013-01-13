Gametrader::Application.routes.draw do
  root to: 'welcome#index'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  delete 'signout', to: 'sessions#destroy', as: :signout
end
