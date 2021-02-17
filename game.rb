# frozen_string_literal: true

class Game
  include Interface

  BET_VALUE = 10

  class WrongOption < StandardError; end

  def run
    create_user(name)
    create_diller
    init_deck
    give_two_cards
    show_cards
    init_game_bank
    make_bets
  end

  private

  attr_reader :user, :diller, :deck, :bank

  def name
    @name ||= ask_user_name
  end

  def create_user(name)
    bank = Bank.new
    @user = User.new(name, bank)
  end

  def create_diller
    bank = Bank.new
    @diller = Diller.new(bank)
  end

  def give_two_cards
    [user, diller].each do |player|
      2.times { give_card(player) }
    end
  end

  def give_card(player)
    player.take_card(random_card)
  end

  def init_deck
    @deck = Deck.new
  end

  def random_card
    deck.delete(deck.sample)
  end

  def show_cards
    [user, diller].each do |player|
      puts ''
      player.show_cards
    end
  end

  def init_game_bank
    @bank = Bank.new(0)
  end

  def make_bets
    [user, diller].each do |player|
      player.place_bet(BET_VALUE)
      bank.add(BET_VALUE)
    end
  end

  def make_user_choose
    option = ask_to_make_choice
    case option
    when 1 # Skip

    when 2 # Take a card

    when 3 # Open cards

    else
      raise WrongOption
    end
  rescue WrongOption
    puts 'You have chosen the wrong option. Choose the right option from the list'
    retry
  end
end
