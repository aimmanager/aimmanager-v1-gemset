source 'https://rubygems.org'

gem 'bugsnag', '~> 6.6', '>= 6.6.3'
gem 'config', '~> 1.6', '>= 1.6.1'
gem 'data_migrate', '~> 3.4'
gem 'pg', '~> 0.21.0'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'rails', '~> 5.1', '>= 5.1.4'
gem 'redis-rails', '~> 5.0', '>= 5.0.2'
gem 'sidekiq', '~> 5.0', '>= 5.0.5'
gem 'sidekiq-cron', '~> 0.6.3'
gem 'sidekiq-history', '~> 0.0.9'
gem 'newrelic_rpm'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'

  gem 'capistrano', '~> 2.15.5'
  gem 'capistrano-rails', '~> 0.0.7'
  gem 'capistrano-ext', '~> 1.2', '>= 1.2.1', require: false
  gem 'pry', '~> 0.11.3'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'dalli', '~> 2.7', '>= 2.7.6'
  gem 'puma', '~> 3.7'
  gem 'slack-notifier', '~> 2.3', '>= 2.3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
