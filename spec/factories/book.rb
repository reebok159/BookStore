FactoryGirl.define do

  factory :book do
    name "Test book"
    price 150.5

    after(:create) do |book|
      book.build_info_book
      book.save
    end
  end

end
