FactoryBot.define do
  factory :order do
    transient do
      book nil
    end

      user nil
      status :in_progress
      checkout_state 'address'

    trait :with_books do
      after(:create) do |order|
        order.order_items << create(:order_item, book: create(:book))
        order.save
      end
    end

    trait :with_given_book do
      after(:create) do |order, evaluator|
        return if evaluator.book.nil?
        order.order_items << create(:order_item, book: evaluator.book)
        order.save
      end
    end
  end
end
