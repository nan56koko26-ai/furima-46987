FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    first_name {"山田"}
    last_name {"太郎"}
    first_name_kana {"ヤマダ"}
    last_name_kana {"タロウ"}
    email {Faker::Internet.unique.email}
    password {"abc123"}
    password_confirmation {"abc123"}
    birth_date {"1991-01-01"}
  end
end