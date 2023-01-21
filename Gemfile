source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

gem "rails", "~> 7.0.4"

gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "rails-i18n"
gem "font-awesome-rails"
gem "font-awesome-sass", "~> 6.2.1"
gem "jbuilder"
gem "jsbundling-rails"
gem "puma", "~> 5.0"
gem "sprockets-rails"
gem "stimulus-rails"
gem "sass-rails"
gem "turbo-rails", "~> 1.0.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :production do
  gem 'pg'
end

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end
