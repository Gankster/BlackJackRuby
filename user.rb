# frozen_string_literal: true

class User < Player
  def show_cards
    cards_border { puts "#{cards.map(&:name).join(' ')} | #{calculate_values}" }
  end
end
