FactoryGirl.define do
  factory :order do
      user nil
      status :in_progress
      checkout_state 'address'

    trait :with_books do
      after(:create) do |order|
        order.order_items << FactoryGirl.create(:order_item, book: FactoryGirl.create(:book))
        order.save
      end
    end
  end
end
