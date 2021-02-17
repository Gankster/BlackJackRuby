# frozen_string_literal: true

require 'securerandom'

class Diller < Player
  def initialize(bank)
    name = "Diller_#{SecureRandom.hex}"
    super(name, bank)
  end

  def show_cards
    cards_border { puts Array.new(cards.size, '*').join(' ') }
  end
end
