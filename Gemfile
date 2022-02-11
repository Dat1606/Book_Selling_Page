source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.2"
gem "faker",  "1.7.3"
gem "bcrypt", "3.1.12"
gem "bootstrap-sass", "3.3.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "coffee-rails", "~> 4.2"
gem "config"
gem "jquery-rails", "4.3.1"
gem "jbuilder", "~> 2.5"
gem "puma", "~> 5.6"
gem "rubocop"
gem "rails", "~> 5.2.0"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "kaminari"
gem "font-awesome-rails"
gem 'carrierwave',     '1.2.2'
gem 'mini_magick',     '4.7.0'
gem 'bootstrap-datepicker-rails'
gem 'jquery-ui-rails'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "sqlite3"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  gem 'fog', '1.42'
  gem 'pg', '0.20.0'
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
