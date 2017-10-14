require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { should have_many(:orders) }
end
