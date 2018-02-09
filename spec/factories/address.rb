FactoryBot.define do
  factory :billing_address, aliases: [:shipping_address] do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip "55343"
    country "Ukraine"
    phone "+380666666666"
  end
end
