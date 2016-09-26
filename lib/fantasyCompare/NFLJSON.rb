require 'httparty'
require 'pry'


class FantasyCompare::NFLJSON
  attr_accessor :position, :week, :players, :players_hash, :list, :info, :detail

  #modifies url to pull proper JSON data
  def self.url(position, week)
    url = "http://api.fantasy.nfl.com/v1/players/stats?statType=weekProjectedStats&season=2016&week=#{week}&position=#{position}&format=json&returnHTML=1"
    response = HTTParty.get(url)
    @players_hash = response.parsed_response

  end

    #modifies url to pull proper JSON data based on user inputs and returns a hashed result
  def self.detail_url
    detail_url = "http://api.fantasy.nfl.com/v1/players/details?playerId=#{@playerId}&statType=seasonStatsformat=json"
    response = HTTParty.get(detail_url)
    @detail_hash = response.parsed_response
  end


  #generates simplefied list of parsed down data from API
  def self.players
    @players = []
    @players_hash["players"].each do |key, value|
      weekProjectedPts = key["weekProjectedPts"]
      name = key["name"]
      playerId = key["id"]
      @players << {name: name, weekProjectedPts: weekProjectedPts, playerId: playerId}
    end
      self.top_ten_list(@players)
  end

    #take the parsed players hash array, sorts it and returns the top 10 projected players in text format
  def self.top_ten_list(players)
     @list = []
     @top_ten = players.sort_by {|key| key[:weekProjectedPts]}.reverse!.first(10)
     #parse into strings
     @top_ten.each do |key, value|
       name = key[:name]
       projected = key[:weekProjectedPts]
       @list <<  "Name: #{name} Projected Points: #{projected}"
     end
  end

  # parses info into numbered list
  def self.list
    @list.each_with_index do |value, index|
      puts "#{index + 1}: #{value}"
    end
  end

  #obtain detail veiw of player
  def self.detail_player_view(info)
    info = info.to_i - 1
    @playerId = @top_ten[info][:playerId]
    @playerName = @top_ten[info][:name]
    @projectedPoints = @top_ten[info][:weekProjectedPts]
  end

  #parses @detail_hash into readable info
  def self.show_detail_veiw
    @note = []
    status = ""
    injury = ""
    @detail_hash["players"].each do |key, value|
      status =  key["status"]
      injury = key["injuryGameStatus"] || "None"
      key["notes"].each do |key, value|
      @note << "Date: #{key["timestamp"]}\n #{key["body"] + key["analysis"]}"
      end
    end
    @detail = "Status: #{status} \nInjury Status: #{injury} \n #{@note.first}"

  end

  #used to display addtional notes
  def self.next_note(note_number)
    puts "\nWould you like to see additional notes (Y/N)?"
    addtional_notes = gets.chomp
    if addtional_notes[0].capitalize == "Y" && note_number <= @note.length-1
      puts @note[note_number]
      note_number += 1
      self.next_note(note_number)
    elsif note_number > @note.length-1 && addtional_notes[0].capitalize == "Y"
      puts "There are no more notes"
      puts "Would You like to see details on another player?"
      do_again = gets.chomp
    elsif addtional_notes[0].capitalize == "N"
      puts "Would You like to see details on another position?"
      do_again = gets.chomp
    end

    if do_again[0].capitalize == "Y"
      FantasyCompare::CLI.new.call
    else
      puts "Goodbye"
    end
  end
end
