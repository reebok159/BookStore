# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { FFaker::Book.genre[0...13] }
  end
end
