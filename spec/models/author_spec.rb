# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'ActiveRecord associations' do
    it { is_expected.to have_and_belong_to_many(:book) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
