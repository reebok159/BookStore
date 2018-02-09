FactoryBot.define do
  factory :review do
    book
    text { FFaker::Lorem.sentence(4) }
    title { FFaker::Name.name }
    rating { rand(1..5) }
  end
end
