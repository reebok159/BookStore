source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'i18n', '~> 0.8.6'
gem 'devise', '~> 4.3'
gem 'cancancan', '~> 2.0'
gem 'omniauth-oauth2', '~> 1.4'
gem 'omniauth-facebook', '~> 4.0'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'simple_form', '~> 3.5'
gem 'country_select', '~> 3.1', '>= 3.1.1'
gem 'haml-rails', '~> 1.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
gem 'carrierwave', '~> 1.1'
gem 'mini_magick', '~> 4.8'
gem 'rails_admin', '~> 1.2'
gem 'fog-aws', '~> 1.4', '>= 1.4.1'
gem "fog-google"
gem "google-api-client", "> 0.8.5", "< 0.9"
gem "mime-types"
gem 'sass-rails', '~> 5.0'
gem 'compass-rails', '~> 3.0', '>= 3.0.2'
gem 'aasm', '~> 4.12', '>= 4.12.2'
gem 'draper', '~> 3.0', '>= 3.0.1'
gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'ffaker'
gem "font-awesome-rails"

group :development, :test do
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem 'capybara', '~> 2.13.0'
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
  gem 'rspec_junit_formatter', '~> 0.3.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'rubycritic'
  gem 'simplecov', :require => false
  gem 'brakeman'
end

group :test do
  gem 'capybara-webkit', '~> 1.14.0'
  gem 'rails-controller-testing'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'transactional_capybara', '~> 0.0.1'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
