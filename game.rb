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

  def players
    @players ||= []
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
    unless user.can_take_card?
      puts 'You cannot take one more card'
      return
    end

    player.take_card(random_card)
  end

  def init_deck
    @deck = Deck.new
  end

  def random_card
    deck.delete(deck.sample)
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
    option = ask_to_make_choice
    case option
    when 1 # Skip
      puts 'Your turn is skipped'
      make_deller_choose
    when 2 # Take a card
      give_card(user)
      user.show_cards
      make_deller_choose
    when 3 # Open cards
      open_cards
      show_results
      start_new_game
    else
      raise WrongOption
    end
  rescue WrongOption
    puts 'You have chosen the wrong option. Choose the right option from the list'
    retry
  end

  def open_cards
    players.each(&:open_cards)
  end

  def show_results
    show_winner(find_winner)
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
      puts 'New game started'
      run
    when 2 # No
      exit
    else
      raise WrongOption
    end
  rescue WrongOption
    puts 'You have chosen the wrong option. Choose the right option from the list'
    retry
  end

  def make_deller_choose
    
  end
end
