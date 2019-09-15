FactoryBot.define do

    factory :user do
        transient do
            username { "john.doe" }
        end
        email { "#{username}@example.com" }
        password { "test123" }
        airline_id { Airline.offset(Random.rand(Airline.count)).first.id }
    end

    factory :random_user, class: User do
        email { Faker::Internet.email}
        password { Faker::String.random(6..10)}
        airline_id { Airline.offset(Random.rand(Airline.count)).first.id }
    end

    factory :confirmed_user, class: User, parent: :random_user do
        # confirmation_token { nil }
        # confirmed_at { Time.now }
        after(:create) { |user| user.confirm }
    end

    factory :random_flight, class: Flight do
        airline_id { Airline.random.first.id }
        src_airport_id { Airport.random.first.id }
        dst_airport_id { Airport.random.where.not(:id => src_airport_id).first.id }
        price { Random.rand(100..500) }
        capacity { Random.rand(50..250) }
        status { :ready_to_book }
        departure_at { Time.now }
        arrival_at { Time.now + 3600 }
    end
end