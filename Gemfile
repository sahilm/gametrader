source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'pg'
gem 'jquery-rails'
gem 'turbolinks'

group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',      github: 'rails/sass-rails'
  gem 'coffee-rails',    github: 'rails/coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
end

group :development do
  gem 'spork-rails', github: 'sahilm/spork-rails', branch: 'rails-4'
  gem 'guard-spork'
  gem 'guard-rspec'
  if RbConfig::CONFIG['arch'] =~ /darwin/
    gem 'rb-fsevent', require: false
  elsif RbConfig::CONFIG['arch'] =~ /linux/
    gem 'rb-inotify', require: false
  end
end