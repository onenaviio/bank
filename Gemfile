source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "dry-initializer"
gem "dry-struct"
gem "pg"
gem "pry-rails"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.7", ">= 6.1.7.2"
gem "rubocop-faker", require: false
gem "rubocop-performance", require: false
gem "rubocop-rails", require: false
gem "rubocop-rspec", require: false

gem "rack-cors"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end
