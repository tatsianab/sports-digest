require 'mail'
require_relative 'users'
class SendMail
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
    subject "Your teams' schedules!"
    body File.read('app/views/text_file.txt')
  end
mail.deliver
#puts mail
end


