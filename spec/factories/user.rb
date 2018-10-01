# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'aabb@hh.de'
    password '12345678'
    is_admin false
    confirmed_at Time.now
  end
end
