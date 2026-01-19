class StockMovement < ApplicationRecord
  belongs_to :product

  validates :change, presence: true, numericality: { other_than: 0 }
  validates :movement_type, presence: true
  validates :reason, presence: true, length: { maximum: 500 }

  enum :movement_type, {
    inbound: 0,
    outbound: 1,
    adjustment: 2
  }
end
