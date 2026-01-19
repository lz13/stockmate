class Shop < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :products, dependent: :destroy

  validates :name, uniqueness: { scope: :location }, presence: true
  validates :location, length: { maximum: 250 }, allow_blank: true
end
