# frozen_string_literal: true

class User < Player
  alias show_cards open_cards
end
