ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require#(:default, ENV['SINATRA_ENV'])


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/users-#{ENV['SINATRA_ENV']}.db"
)

 require_all 'app/'

