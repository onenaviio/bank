source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "bootsnap", ">= 1.4.4", require: false
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
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
