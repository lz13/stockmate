class User < ApplicationRecord
  has_many :shops, foreign_key: :owner_id, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
