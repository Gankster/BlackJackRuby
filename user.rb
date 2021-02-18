# frozen_string_literal: true

class User < Player
  alias show_cards open_cards

  # def show_cards
  #   cards_border { puts "#{cards.map(&:name).join(' ')} | #{calculate_values}" }
  # end
end
