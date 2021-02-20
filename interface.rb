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
    puts player.nil? ? 'Draw' : "Winner: #{player.name}"
    puts '****************************'
    puts ''
  end

  def play_new_game
    puts %(
    Want to start a new game?
      1. Yes
      2. No
    )
    gets.chomp.to_i
  end

  def enough_cards_msg
    show_msg('You cannot take one more card')
  end

  def wrong_option_msg
    show_msg('You have chosen the wrong option. Choose the right option from the list')
  end

  def new_game_msg
    show_msg('New game started')
  end

  def skip_msg(player)
    show_msg("#{player.name} skip his turn")
  end

  def money_limit(player)
    show_msg("#{player.name} don't have money")
  end

  def cards_border
    puts ''
    puts "===== #{name} cards ====="
    puts ''
    yield if block_given?
    puts ''
  end

  def show_msg(msg)
    puts ''
    puts msg.to_s
  end
end
