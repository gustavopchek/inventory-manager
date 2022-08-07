FactoryBot.define do
  factory :store do
    name { Faker::Name.name  }
    uid { Faker::Name.unique.name  }
  end
end
