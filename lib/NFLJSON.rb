require 'httparty'
require 'pry'


class NFLJSON
  attr_accessor :position, :week, :players, :players_hash, :list, :info, :detail

  #modifies url to pull proper JSON data
  def self.url(position, week)
    url = "http://api.fantasy.nfl.com/v1/players/stats?statType=weekProjectedStats&season=2016&week=#{week}&position=#{position}&format=json&returnHTML=1"
    response = HTTParty.get(url)
    @players_hash = response.parsed_response
  end

    #modifies url to pull proper JSON data based on user inputs and returns a hashed result
  def self.detail_url(id)
    detail_url = "http://api.fantasy.nfl.com/v1/players/details?playerId=#{id}&statType=seasonStatsformat=json"
    response = HTTParty.get(detail_url)
    @detail_hash = response.parsed_response
  end

  # Takes input to parse proper JSON Position data by returing proper url link
  # Mai CLI functionality
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
      puts "Please select a week for stats"
      @week = gets.chomp
    self.url(@position, @week)
    self.players
    self.top_ten_list(@players)
      puts "Please select a team to find out more info"
    self.list(@list)
      @info = gets.chomp
    self.detail_player_view(@info)
      puts "Information for this team is as follows"
    self.detail_url(@playerId)
    self.show_detail_veiw
      puts @detail
    self.next_note(1) #increments notes
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
    @players
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
  def self.list(list)
    list.each_with_index do |value, index|
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
      puts "Would You like to see details on another player?"
      do_again = gets.chomp
    end

    if do_again[0].capitalize == "Y"
      self.inputs
    end

  end


  binding.pry
end
