source 'https://rubygems.org'
ruby "1.8.7"

gem 'rails', '2.3.18'

gem 'rdoc'
gem 'rmagick', :require => 'RMagick'

gem 'RedCloth'

group :test, :development  do
  #Only needed if you're using mysql locally
  #gem 'mysql'
  gem "sqlite3"
end

group :production do
  gem "pg"
end