# frozen_string_literal: true

require 'securerandom'

class Dealer < Player
  def initialize(bank)
    name = "Dealer_#{SecureRandom.hex(5)}"
    super(name, bank)
  end

  def show_cards
    cards_border { puts Array.new(cards.size, '*').join(' ') << " | Money: #{bank.amount}" }
  end

  def enough_value?
    calculate_values >= 17
  end
end
