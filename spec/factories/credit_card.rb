FactoryBot.define do
  factory :credit_card do
    number "1111222233334444"
    name { FFaker::Name.name }
    expires '01/19'
    cvv '123'
  end
end
