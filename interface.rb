# frozen_string_literal: true

module Interface
  def ask_user_name
    puts 'Enter your name:'
    gets.chomp
  end

  def ask_to_make_choice
    puts %(
      Сhoose one of the options:
        1. Skip
        2. Take a card
        3. Open cards
    )
    gets.chomp.to_i
  end

  def show_winner(player)
    puts ''
    puts '********** Result **********'
    puts "Winner: #{player.name}"
    puts '****************************'
    puts ''
  end

  def play_new_game
    puts %(
      Want to start a new game?
        1. Yes
        2. No
        3. Continue
    )
    gets.chomp.to_i
  end
end
