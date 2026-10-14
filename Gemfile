source "https://rubygems.org"

gem "rails", "~> 8.0.0"
gem "json", "< 3.0"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "ruby-openai"
gem "bootsnap", require: false

group :development, :test do
  gem "sqlite3", ">= 2.1"
  gem "dotenv-rails"
  gem "debug", platforms: %i[mri windows]
end

group :production do
  gem "pg", "~> 1.1"
end

gem "tzinfo-data", platforms: %i[windows jruby]
