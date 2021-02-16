# frozen_string_literal: true

class Player
  attr_reader :bank, :cards, :name

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def place_bet(value)
    bank.take(value)
  end

  def add_money(value)
    bank.add(value)
  end
end
