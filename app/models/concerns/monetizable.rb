module Monetizable
  extend ActiveSupport::Concern

  included do
    validates :price_in_cents, presence: true, numericality: { greater_than: 0 }
  end

  def price
    price_in_cents / 100.0
  end

  def price=(euros)
    self.price_in_cents = (euros.to_f * 100).round
  end
end
