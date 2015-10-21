require 'open-uri'
require 'nokogiri'
require_relative 'football_teams'

module FootballSchedule
  extend FootballTeams
  @@teams = FootballTeams.get

  def scrape(team_name)
    team_abr = @@teams.key(team_name)
    url = open("http://espn.go.com/nfl/team/schedule/_/name/#{team_abr}/#{team_name.gsub(" ","-")}").read
    team_schedule = Nokogiri::HTML(url)
    all_games = team_schedule.css("table tr[class*='row team']").children.map {|x|  x.children.text if x.children.text!= ""}.compact
  end

  def game_hash(team_name)
    games_info = self.scrape(team_name)
    games = []
    games_info.each_with_index do |game_info, index|
      if (game_info.to_i != 0 && game_info.split(" ").size == 1)
        games << [games_info[index..index+3]]
      end
    end
    games.flatten(1)[7] #[week, date, @/vs opponent, time/channel] ## does not handle BYE weeks! These get lost in scraping
  end
end
