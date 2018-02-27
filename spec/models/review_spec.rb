require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(500) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(80) }
  end
end
