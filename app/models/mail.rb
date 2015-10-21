require 'mail'
require 'pry'
require 'erb'
require_relative 'users'

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'localhost',
            :user_name            => 'this.weeks.sports',
            :password             => 'jessietatsiana',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }



Mail.defaults do
  delivery_method :smtp, options
end

user = User.new("Jessie")
user.football_team = "New York Giants"

mail = Mail.new do
  user.create_body

  from 'this.weeks.sports@gmail.com'
  to 'nadler.jessie@gmail.com'
  subject "I'm sending this with our app!"
  body File.read('lib/test.txt')
end

#mail.deliver
puts mail

