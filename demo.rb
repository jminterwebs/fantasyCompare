require 'httparty'
require 'pry'



  url = "http://api.fantasy.nfl.com/v1/players/stats?statType=weekProjectedStats&season=2016&week=3&position=QB&format=json&returnHTML=1"
  response = HTTParty.get(url)
  @players_hash = response.parsed_response



  #modifies url to pull proper JSON data based on user inputs and returns a hashed result

  detail_url = "http://api.fantasy.nfl.com/v1/players/details?playerId=100029&statType=seasonStatsformat=json"
  response = HTTParty.get(detail_url)
  @detail_hash = response.parsed_response


binding.pry
