require 'httparty'
require 'pry'


class NFLJSON
  attr_accessor :position, :url

  #take a url with variables to get proper JSON data
  def self.url(position)
    @url =  "http://api.fantasy.nfl.com/v1/players/stats?statType=weekStats&season=2016&week=1&position=#{position}&format=json&returnHTML=1"
  end



# Takes input to parse proper JSON Position data by returing proper url link
def self.inputs
  positions = ["QB","RB","WR","TE","K","DEF"]
  puts "Please pick a position (1-6) \n1.QB\n2.RB\n3.WR\n4.Te\n5.K\n6.DEF"
  pos_input = gets.chomp
  pos_input = pos_input.to_i-1
  if !pos_input.between?(0,5)
    puts "Invalid Input"
    inputs
  else
    @position = positions[pos_input]
  end

end

def self.players(url)
  ###move out
  response = HTTParty.get(url)
  test = response.parsed_response

  players = []
  test["players"].each do |key, value|
    weekProjectedPts = key["weekProjectedPts"]
    name = key["name"]
    players << {name: name, weekProjectedPts: weekProjectedPts}
  end
  players
end


  binding.pry

end
