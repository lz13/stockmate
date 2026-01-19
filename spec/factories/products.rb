FactoryBot.define do
  factory :product do
    association :shop

    sequence(:name) { |n| "Product #{n}" }
    price_in_cents { 1099 } # $10.99 in cents
    stock_quantity { 100 }
  end
end