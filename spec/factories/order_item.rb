FactoryGirl.define do
  factory :order_item do
      order
      book nil
      quantity 1
  end

end
