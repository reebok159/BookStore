# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:addressable) }
  end

  include_examples 'address_tests'
end
