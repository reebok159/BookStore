require 'rails_helper'

RSpec.describe Author, type: :model do

  describe 'ActiveRecord associations' do
    it { should have_and_belong_to_many(:book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
