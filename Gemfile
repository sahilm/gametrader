source 'https://rubygems.org'

ruby "1.9.3"

gem 'rake'
gem 'puma'
gem 'rails', github: 'rails/rails'
gem 'arel',  github: 'rails/arel'
gem 'pg'
gem 'jquery-rails'
gem 'turbolinks'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'the_games_db', github: 'sahilm/the_games_db'

group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',      github: 'rails/sass-rails'
  gem 'coffee-rails',    github: 'rails/coffee-rails'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spork-rails', github: 'sahilm/spork-rails', branch: 'rails-4'
  gem 'guard-spork'
  gem 'guard-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
end

group :linux do
  gem 'rb-inotify'
end
