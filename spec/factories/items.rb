FactoryBot.define do
  factory :item do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence(word_count: 10)}
    price {Faker::Number.between(from: 300, to: 9_999_999)}
    category_id {2}
    status_id {2}
    shipping_fee_id {2}
    prefecture_id {2}
    delivery_time_id {2}
    association :user
  end
end
