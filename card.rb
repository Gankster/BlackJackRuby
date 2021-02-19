# frozen_string_literal: true

class Card
  attr_reader :char, :suit, :value, :name

  def initialize(char, suit, value)
    @char = char
    @value = value
    @suit = suit
    @name = "#{char}#{suit}"
  end
end
