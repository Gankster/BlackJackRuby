# frozen_string_literal: true

require_relative 'interface'

class Game
  include Interface

  BET_VALUE = 10

  class WrongOption < StandardError; end

  attr_reader :players

  def initialize
    @winner = nil
    @players = []
  end

  def run
    create_user(name)
    create_diller
    start_game
  end

  private

  attr_reader :user, :diller, :deck, :bank
  attr_accessor :winner

  def start_game
    init_deck
    give_two_cards
    show_cards
    init_game_bank
    make_bets
    make_user_choose
  end

  def name
    @name ||= ask_user_name
  end

  def create_user(name)
    bank = Bank.new
    @user = User.new(name, bank)
    players << @user
  end

  def create_diller
    bank = Bank.new
    @diller = Diller.new(bank)
    players << @diller
  end

  def give_two_cards
    players.each do |player|
      2.times { give_card(player) }
    end
  end

  def give_card(player)
    unless player.can_take_card?
      puts 'You cannot take one more card'
      return
    end

    player.take_card(random_card)
  end

  def init_deck
    @deck = Deck.new
  end

  def random_card
    deck.cards.delete(deck.cards.sample)
  end

  def show_cards
    players.each do |player|
      puts ''
      player.show_cards
    end
  end

  def init_game_bank
    @bank = Bank.new(0)
  end

  def make_bets
    players.each do |player|
      player.place_bet(BET_VALUE)
      bank.add(BET_VALUE)
    end
  end

  def make_user_choose
    finish_game if enough_cards?
    case ask_to_make_choice
    when 1 # Skip
      puts 'Your turn is skipped'
      make_deller_choose
    when 2 # Take a card
      give_card(user)
      show_cards
      make_deller_choose
    when 3 # Open cards
      finish_game
    else
      raise WrongOption
    end
  rescue WrongOption
    puts 'You have chosen the wrong option. Choose the right option from the list'
    retry
  end

  def finish_game
    open_cards
    show_results
    start_new_game
  end

  def open_cards
    players.each(&:open_cards)
  end

  def show_results
    self.winner = find_winner
    show_winner(winner)
    distribute_win
  end

  def find_winner
    return diller unless user.valid_result?
    return user unless diller.valid_result?

    res = user <=> diller

    return user if res.positive?
    return diller if res.negative?
  end

  def start_new_game
    case play_new_game
    when 1 # Yes
      continue_game
    when 2 # No
      exit
    else
      raise WrongOption
    end
  rescue WrongOption
    puts 'You have chosen the wrong option. Choose the right option from the list'
    retry
  end

  def continue_game
    self.winner = nil
    players.each(&:update_cards)
    puts 'New game started'
    start_game
  end

  def distribute_win
    if winner.nil?
      amount = bank.amount / 2
      players.each do |p|
        p.add_money(amount)
      end
    else
      winner.add_money(bank.amount)
    end
  end

  def make_deller_choose
    finish_game if enough_cards?
    if diller.enough_value?
      puts "Diller's turn is skipped"
    else
      give_card(diller)
      show_cards
    end
    make_user_choose
  end

  def enough_cards?
    players.map { |p| p.cards.size }.all?(3)
  end
end
