source 'https://rubygems.org'

gem 'rails', '>= 4.0.3'
gem 'sprockets', '2.11.0'
#For Development we use sqlite3, for
#Production move to postgres
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'thin'
end


group :production do
  gem 'rails_12factor'
end


group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
end

group :development, :test do
    gem 'railroady'
end

# Use SCSS for stylesheets



# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  gem 'sdoc', require: false
end

gem "bower-rails", ">= 0.7.1"
gem 'ruby-bower', group: :assets


# For password and user auth
gem 'bcrypt-ruby'

# For JSON API support

gem 'rabl'
gem 'oj'


gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'turbolinks'

# For Semantic UI
gem 'therubyracer', platforms: :ruby # or any other runtime
gem 'less-rails'
gem 'autoprefixer-rails'

gem 'compass-rails'
gem 'semantic-ui-sass'


# For Users

# For backbone support

gem 'backbone-syphon-rails'

gem 'eco'

gem 'gon'

gem 'js-routes'

gem "paperclip", "~> 4.1"

gem 'redis', '2.1.1'

gem 'streamio-ffmpeg'

gem 'mongoid' , '4.0.0'
gem 'mongoid_paranoia'
gem "mongoid-paperclip", :require => "mongoid_paperclip"

gem 'puma', '2.9.1'
gem 'warden', '1.2.3'

gem 'protected_attributes'

gem 'base62', '1.0.0'

gem 'rmagick', '2.13.2'
# For deployment
gem 'unicorn'
gem 'capistrano'
group :development do
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-unicorn-nginx', '~> 3.1.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rbenv', '~> 2.0'
end