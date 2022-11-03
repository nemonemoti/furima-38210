FactoryBot.define do
  factory :item do
    product_name         { Faker::Name.initials }
    product_detail       { Faker::Lorem.sentence }
    category_id          { 2 }
    product_condition_id { 2 }
    delivery_fee_id { 2 }
    area_id           { 3 }
    days_to_ship_id   { 2 }
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/item-sample.png'), filename: 'test_image.png')
    end
  end
end