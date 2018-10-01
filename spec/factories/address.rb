# frozen_string_literal: true

FactoryBot.define do
  factory :address, aliases: %i[shipping_address billing_address] do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::Address.street_name.gsub(/[\W_]/, '') }
    city { FFaker::Address.city.gsub(/[\W_]/, '') }
    zip { FFaker::AddressUS.zip_code }
    country 'Ukraine'
    phone { "#{FFaker::PhoneNumber.phone_calling_code}#{rand(10..99)}#{rand(1000..99_999)}" }
  end
end
