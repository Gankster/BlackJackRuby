# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = create_cards
  end

  private

  def create_cards
    cards = []
    Card::CARDS.each do |char, value|
      Card::SUITS.each_value do |suit|
        cards << Card.new(char, suit, value)
      end
    end
    cards
  end
end
