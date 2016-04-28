source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'rails-api'
gem 'sqlite3'
gem 'active_model_serializers', '~> 0.9.2'
gem 'devise'
gem 'devise_token_auth'
# gem 'simple_token_authentication'
gem 'omniauth'
gem 'responders', '~> 2.0'
gem 'rack-cors', require: 'rack/cors'
gem 'robocop'
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'sdoc', '~> 0.4.0', group: :doc


gem 'unicorn', platforms: [:ruby]

# use monitor of newrelic to alanytics data
gem 'newrelic_rpm'
gem 'pg'
gem 'net-ssh'

# pagination for data
gem 'kaminari'
gem 'api-pagination'

# to process background jobs with redis or rabbitmq
gem 'sidekiq'
# gem 'resque'

# gem 'amqp'

gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'redis-store'

# gem 'redic'
gem 'ohm'
gem 'ohm-contrib'
gem 'ohm-expire'

# enable elastic if you use full text search
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

group :development, :test do
  gem 'faker'
  gem 'simplecov', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'byebug'
  gem 'spring'
end

group :deployment do
  gem 'capistrano', '=3.4.1', require: true
  gem 'capistrano-rails', require: true
  gem 'capistrano-rvm', require: true
  gem 'capistrano-rbenv', require: true
  gem 'capistrano-bundler', require: true
  gem 'capistrano3-unicorn', require: true
end
# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
