require_relative './config/environment.rb'
require 'sinatra/activerecord/rake'

task :environment do
  require_relative './config/environment'
end

task :console do
  def reload!
    load_all 'app'
  end
  
  Pry.start
end
