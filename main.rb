# frozen_string_literal: true

require_relative 'game'
require_relative 'bank'
require_relative 'deck'
require_relative 'card'
require_relative 'player'
require_relative 'user'
require_relative 'diller'

game = Game.new
game.run
