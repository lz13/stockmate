FactoryBot.define do
  factory :shop do
    association :owner, factory: :user

    sequence(:name) { |n| "Shop #{n}" }
    location { "Location" }
  end
end
