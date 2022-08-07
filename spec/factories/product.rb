FactoryBot.define do
  factory :product do
    name { Faker::Name.name  }
    uid { Faker::Name.unique.name  }
  end
end
