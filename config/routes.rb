Gametrader::Application.routes.draw do
  root to: 'welcome#index'
  get  'auth/:provider/callback', to: 'sessions#create'
  post 'auth/:provider/callback', to: 'sessions#create'
end
