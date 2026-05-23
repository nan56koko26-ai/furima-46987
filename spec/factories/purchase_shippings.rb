FactoryBot.define do
  factory :purchase_shipping, class: 'PurchaseShipping' do
    association :user
    association :item
    postal_code {"123-4567"}
    prefecture_id {2}
    city { "テスト市" }
    address { "テスト1-1" }
    building_name { "" }
    phone_number { "09012345678" }
    token {"tok_abcdefghijk00000000000000000"}
    initialize_with { new(attributes) }
  end
end
