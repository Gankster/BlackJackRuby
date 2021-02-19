# frozen_string_literal: true

class Bank
  class LimitExceeded < StandardError; end

  attr_reader :amount

  def initialize(amount = 100)
    @amount = amount
  end

  def add(value)
    self.amount += value.to_i
  end

  def take(value)
    raise LimitExceeded, "You don't have enough money" if value > amount

    self.amount -= value.to_i
  end

  private

  attr_writer :amount
end
