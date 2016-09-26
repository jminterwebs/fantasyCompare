class FantasyCompare::CLI

  def call
    inputs
  end

  # Takes input to parse proper JSON Position data by returing proper url link
  # Mai CLI functionality
  def inputs
    positions = ["QB","RB","WR","TE","K","DEF"]

    # Select position to look at
    puts "Please pick a position (1-6) \n1.QB\n2.RB\n3.WR\n4.Te\n5.K\n6.DEF"
    pos_input = gets.chomp
    pos_input = pos_input.to_i-1

    # Validate position data
    while !pos_input.between?(0,5)
      puts "Invalid Input\n"
      puts "Please pick a position (1-6) \n1.QB\n2.RB\n3.WR\n4.Te\n5.K\n6.DEF"
      pos_input = gets.chomp
      pos_input = pos_input.to_i-1
    end
      position = positions[pos_input]

      # Select week
      puts "Please select a week for stats (1-17)"
      week = gets.chomp
      week = week.to_i

    # Validate week data
    while !week.between?(1,17)
      puts "Invalid Input\n"
      puts "Please select a week for stats (1-17)"
      week = gets.chomp
      week = week.to_i
    end

    FantasyCompare::NFLJSON.url(position, week)
    FantasyCompare::NFLJSON.players
      puts "Please select a team to find out more info (1-10)\n\n"
    FantasyCompare::NFLJSON.list

    #Select player for detail veiw
    info = gets.chomp
    info = info.to_i

    #Validate input
    while !info.between?(1,10)
      puts "Invalid Input\n"
      puts "Please select a team to find out more info (1-10)\n\n"
    FantasyCompare::NFLJSON.list
    info = gets.chomp
    info = info.to_i
    end

    FantasyCompare::NFLJSON.detail_player_view(info)
      puts "Information for this team is as follows\n\n"
    FantasyCompare::NFLJSON.detail_url
    puts FantasyCompare::NFLJSON.show_detail_veiw
    FantasyCompare::NFLJSON.next_note

  end
end
