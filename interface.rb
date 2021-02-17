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
end
