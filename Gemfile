source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'i18n', '~> 0.9.3'
gem 'devise', '~> 4.4', '>= 4.4.1'
gem 'omniauth', '~> 1.8', '>= 1.8.1'
gem 'omniauth-facebook', '~> 4.0'
gem 'activeadmin', '~> 1.2', '>= 1.2.1'
gem 'cancancan', '~> 2.1', '>= 2.1.3'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'carrierwave', '~> 1.2', '>= 1.2.2'
gem 'mini_magick', '~> 4.8'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'aasm', '~> 4.12', '>= 4.12.3'
gem 'haml', '~> 5.0', '>= 5.0.4'
gem 'simple_form', '~> 3.5'
gem 'country_select', '~> 3.1', '>= 3.1.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'draper', '~> 3.0', '>= 3.0.1'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot', '~> 4.8', '>= 4.8.2'
  gem 'ffaker', '~> 2.8', '>= 2.8.1'
  gem 'rubocop', '~> 0.52.1'
  gem 'shoulda', '~> 3.5'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data'
