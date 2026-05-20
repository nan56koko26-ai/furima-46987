FactoryBot.define do
  factory :shipping_address do
    association :purchase
    postal_code {"123-4567"}
    prefecture_id {2}
    city { "テスト市" }
    address { "テスト1-1" }
    building_name { "" }
    phone_number { "09012345678" }
  end
end
