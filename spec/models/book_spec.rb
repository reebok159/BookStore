require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'ActiveRecord associations' do
    it { should have_many(:order_items).with_foreign_key('item_id') }
    it { should have_many(:orders).through(:order_items) }
    it { should have_many(:reviews) }
    it { should belong_to(:category) }
    it { should have_many(:images).dependent(:destroy) }
    it { should have_and_belong_to_many(:authors) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
