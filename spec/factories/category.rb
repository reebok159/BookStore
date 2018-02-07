FactoryBot.define do
  factory :category do
    name { FFaker::Book.genre[0...20] }
  end
end
