FactoryBot.define do
  factory :inventory do
    amount { rand(0..100) }

    association :product
    association :store
  end
end
