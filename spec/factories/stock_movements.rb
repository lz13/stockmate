FactoryBot.define do
  factory :stock_movement do
    association :product

    change { 10 }
    movement_type { :inbound } # 0
    reason { "Initial stock" }

    trait :out do
      movement_type { :outbound } # 1
      change { 5 }
      reason { "Customer order" }
    end

    trait :adjustment do
      movement_type { :adjustment } # 2
      change { -3 }
      reason { "Inventory correction" }
    end
  end
end