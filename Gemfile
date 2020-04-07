source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'bootstrap', '~> 4.1', '>= 4.1.1'
gem 'devise'
gem 'rails', '~> 5.2.4', '>= 5.2.4.1'
gem 'rest-client', '~> 2.0', '>= 2.0.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'dotenv-rails'
gem 'puma', '~> 3.12'
gem 'pry', '~> 0.11.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'settingslogic'
gem 'orm_adapter', '~> 0.5.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'populator'
  gem 'sprockets-derailleur'
  gem 'faker'
end

group :development do
  gem 'capybara', '>= 2.15'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'selenium-webdriver'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec'
  gem 'rspec-rails', '~> 3.7'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
