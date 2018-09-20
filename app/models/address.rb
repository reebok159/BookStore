# frozen_string_literal: true

class Address < ApplicationRecord
  enum kind: %w[billing shipping]

  validates :kind, inclusion: { in: kinds.keys }, presence: true
  belongs_to :addressable, polymorphic: true
  include AddressValidator
end
