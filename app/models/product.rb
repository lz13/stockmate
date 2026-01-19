class Product < ApplicationRecord
  include Monetizable

  belongs_to :shop
  has_many :stock_movements, dependent: :destroy

  validates :name, presence: true
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
