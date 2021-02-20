# frozen_string_literal: true

class Card
  SUITS = {
    spade: "\u2660",
    heart: "\u2665",
    diamond: "\u2666",
    club: "\u2663"
  }.freeze

  CARDS = {
    '2' => [2],
    '3' => [3],
    '4' => [4],
    '5' => [5],
    '6' => [6],
    '7' => [7],
    '8' => [8],
    '9' => [9],
    '10' => [10],
    'B' => [10],
    'Q' => [10],
    'K' => [10],
    'A' => [1, 11]
  }.freeze

  attr_reader :char, :suit, :value, :name

  def initialize(char, suit, value)
    @char = char
    @value = value
    @suit = suit
    @name = "#{char}#{suit}"
  end
end
