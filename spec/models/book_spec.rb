require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'ActiveRecord associations' do
    it { should have_many(:order_items).with_foreign_key('item_id') }
    it { should have_many(:orders).through(:order_items) }
    it { should have_many(:reviews) }
    it { should have_one(:info_book).dependent(:destroy) }
    it { should accept_nested_attributes_for(:info_book) }
    it { should belong_to(:category) }
    it { should have_many(:images).dependent(:destroy) }
    it { should accept_nested_attributes_for(:images) }
    it { should have_and_belong_to_many(:authors) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
