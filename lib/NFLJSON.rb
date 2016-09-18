require 'httparty'

require 'pry'



url = 'http://api.fantasy.nfl.com/v1/players/stats?statType=weekStats&season=2016&week=1&position=QB&format=json&returnHTML=1'

response = HTTParty.get(url)
test = response.parsed_response

def players(url)
  player = []
  url["players"].each do |key, value|
    player << key["name"]
  end
  player
  binding.pry
end

  players(test)
