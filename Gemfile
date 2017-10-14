source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
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
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'compass-rails', '~> 3.0', '>= 3.0.2'
gem 'aasm', '~> 4.12', '>= 4.12.2'



# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'ffaker'

group :development, :test do
  gem 'capybara', '~> 2.13.0'
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'
  gem 'pry'

  gem 'rubycritic'
  gem 'simplecov'
  gem 'brakeman'
end

group :test do
  gem 'capybara-webkit', '~> 1.14.0'
  gem 'rails-controller-testing'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'simplecov', :require => false
  gem 'shoulda-matchers', '~> 3.1'
  gem 'transactional_capybara', '~> 0.0.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
