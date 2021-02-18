# frozen_string_literal: true

class Player
  attr_reader :bank, :cards, :name

  ACE_CARD_CHAR = 'A'
  WINNING_VALUE = 21

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

  def take_card(card)
    cards << card
  end

  def show_cards
    raise NotImplementedError, 'Should realize in subclass'
  end

  def cards_border
    header = "===== #{name} cards ====="
    puts header
    puts ''
    yield if block_given?
    puts ''
    puts '=' * header.length
  end

  def open_cards
    cards_border { puts "#{cards.map(&:name).join(' ')} | #{calculate_values}" }
  end

  def calculate_values
    if cards.size == 3 && ace?
      values = []
      %i[min max].each do |m|
        val = sum_values(m)
        values << val if val <= 21
      end
      values.max
    else
      sum_values
    end
  end

  def sum_values(method = :max)
    cards.map(&:value).sum(&method)
  end

  def ace?
    cards.map(&:char).include?(ACE_CARD_CHAR)
  end

  def can_take_card?
    cards.size < 3
  end

  def valid_result?
    compare_winning_score_with(calculate_values) <= 0
  end

  def compare_winning_value_with(player_value)
    player_value <=> WINNING_VALUE
  end

  def <=>(other)
    self <=> other
  end
end
