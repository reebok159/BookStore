# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { FFaker::Book.author }
  end
end
