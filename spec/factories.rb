FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant#{n}" }
    email { Faker::Internet.email }
    phone "0191234567"
  end

  factory :guest do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end

  factory :reservation do
    restaurant nil
    table nil
    shift nil
    guest nil
    guest_count 2
    reservation_at { Time.now.utc }
  end

  factory :shift do
    name { %w(Morning Evening Night).sample }
    start_at 32400
    end_at 54000
    restaurant
  end

  factory :table do
    sequence(:name) { |n| "Table#{n}" }
    min_capacity 1
    max_capacity 10
    restaurant
  end

end
