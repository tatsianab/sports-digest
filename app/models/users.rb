require 'erb'
#require 'activerecord'#, :require => "active_record"
#require 'sinatra-activerecord'
require_relative 'scrapers/football_schedule'
class User# < ActiveRecord::Base
  include FootballSchedule
  attr_accessor :name, :email, :football_team
  def initialize(name)
    @name = name
  end

  # def my_team_schedule
  #   next_week = @user.game_hash(self.football_team).map do |game| 
  #     if game[1] #incorperate DateTime comparison here
  #       game.slice(1,3)
  #     end
  #   end
  #   next_week[-1] = @team_info[-1].split(" ")[0..1].join(" ")
  # end

  def create_body
    @user = self
    # when my_team_schedule works, line 24 will become @team_info = my_team_schedule, line 25 will be removed
    @team_info = @user.game_hash("New York Giants").slice(1,3)
    @team_info[-1] = @team_info[-1].split(" ")[0..1].join(" ")
    string = File.read('app/views/email_body.erb')

    template = ERB.new(string)
    result = template.result(binding)
    File.write('app/views/text_file.txt', result)
  end
end