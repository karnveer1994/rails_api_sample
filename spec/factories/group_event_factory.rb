FactoryBot.define do
  factory :group_event do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    start_date { Date.today }
    end_date { Date.today + 5.day }
    duration { 5 }
    location { Faker::Address.city }
  end
end
