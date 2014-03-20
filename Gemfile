source 'https://rubygems.org'

gem 'rails', '>= 4.0.3'

#For Development we use sqlite3, for 
#Production move to postgres
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'thin'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end


group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
end

# Use SCSS for stylesheets

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  gem 'sdoc', require: false
end

# For Semantic UI 
gem 'therubyracer', platforms: :ruby # or any other runtime
gem 'less-rails'
gem 'autoprefixer-rails'

gem 'compass-rails'
gem 'semantic-ui-sass'

# For backbone support
gem 'backbone-on-rails'
gem "marionette-rails"
gem 'eco'

# For deployment
gem 'capistrano'
gem 'unicorn'

# For password and user auth
gem 'bcrypt-ruby'
gem 'email_validator'

# For JSON API support 

gem 'rabl'
gem 'oj'

gem 'gon'

gem 'js-routes'

gem 'newrelic_rpm'

gem 'backbone-syphon-rails'

gem 'toastr-rails'