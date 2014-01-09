source 'https://rubygems.org'

gem 'rails', '4.0.0'

#For Development we use sqlite3, for 
#Production move to postgres
group :development, :test do
  gem 'sqlite3', '>= 1.3.8'
  gem 'rspec-rails', '>= 2.13.1'
end

group :production do
  gem 'pg', '>= 0.15.1'
  gem 'rails_12factor', '>= 0.0.2'
end


group :test do
  gem 'selenium-webdriver', '>=2.35.1'
  gem 'capybara', '>=2.1.0'
end

# Use SCSS for stylesheets

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end

# For Semantic UI 
gem 'therubyracer', platforms: :ruby # or any other runtime
gem 'less-rails'
gem 'autoprefixer-rails'
gem 'semantic-ui-rails'

# For backbone support
gem 'backbone-on-rails'

# For deployment
gem 'capistrano'
gem 'unicorn'