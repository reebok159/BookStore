require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to have_many(:orders) }
end
