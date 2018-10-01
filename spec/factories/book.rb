# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { FFaker::Book.title }
    price { rand(1.0..150.0) }
  end
end
