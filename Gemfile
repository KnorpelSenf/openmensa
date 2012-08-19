source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'jquery-rails'

gem 'haml'
gem 'rabl'
gem 'msgpack', '~> 0.4.5'
gem 'oj'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'doorkeeper',    '~> 0.4.2'
gem 'rails-i18n'
gem 'attribute_ext', '>= 1.4.0'
gem 'cancan'
gem 'gravtastic'
gem 'rails-timeago', '>= 1.3.0'
gem 'bcrypt-ruby',   '~> 3.0.0'
gem 'paperclip'
gem 'versionist'
gem 'whenever', require: false
gem 'rack-piwik', require: 'rack/piwik'
gem 'geocoder'
gem 'leaflet-rails', '~> 0.4.2.beta1'

gem 'sqlite3'
gem 'pg'

group :assets do
  gem "sass", "~> 3.2.0"
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier'
  gem 'compass-rails'
  gem 'bourbon'
end

group :development, :test do
  gem 'sqlite3'
  gem 'thin'
  gem 'rspec-rails', '~> 2.0'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'capistrano_colors'
end

group :test do
  gem 'timecop'
  gem 'accept_values_for'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'capybara',       require: false
  gem 'poltergeist',    require: false
  gem 'turn',           require: false
  gem 'guard-rspec',    require: false
  gem 'guard-spork',    require: false
  gem 'simplecov',      require: false
  gem 'simplecov-rcov', require: false
  gem 'spork-rails', '>= 3.2.0'
  gem 'factory_girl_rails', '>= 3.3.0', require: false
end

# load Gemfile.local
local_gemfile = File.dirname(__FILE__) + '/Gemfile.local'
if File.file?(local_gemfile)
  self.instance_eval Bundler.read_file(local_gemfile)
end
