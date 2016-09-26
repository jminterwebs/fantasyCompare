class FantasyCompare::CLI
  attr_accessor :list

  def call
    inputs
  end

  # Takes input to parse proper JSON Position data by returing proper url link
  # Mai CLI functionality
  def inputs
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
      puts "Please select a week for stats (1-17)"
      @week = gets.chomp
    FantasyCompare::NFLJSON.url(@position, @week)
    FantasyCompare::NFLJSON.players
      puts "Please select a team to find out more info"
    FantasyCompare::NFLJSON.list
      @info = gets.chomp
    FantasyCompare::NFLJSON.detail_player_view(@info)
      puts "Information for this team is as follows"
    FantasyCompare::NFLJSON.detail_url
    puts FantasyCompare::NFLJSON.show_detail_veiw
    FantasyCompare::NFLJSON.next_note

  end
end
