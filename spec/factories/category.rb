FactoryBot.define do
  factory :category do
    name { FFaker::Book.genre[0...13] }
  end
end
