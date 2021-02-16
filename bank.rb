# frozen_string_literal: true

class Bank
  class LimitExceeded < StandardError; end

  attr_reader :amount

  def initialize(amount)
    @amount = amount || 100
  end

  def add(value)
    self.amount += value
  end

  def take(value)
    raise LimitExceeded, "You don't have enough money" if value > amount

    self.amount -= value
  end

  private

  attr_writer :amount
end
