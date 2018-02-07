require 'rails_helper'

RSpec.describe CreditCard, type: :model do

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:cvv) }
    context 'with invalid attributes' do
      it { is_expected.to allow_values("123", "112", "335").for(:cvv) }
      it { is_expected.not_to allow_values("12", "12ss", "1244", "asd").for(:cvv) }
    end

    it { is_expected.to validate_presence_of(:expires) }
    context 'with invalid attributes' do
      it do
        is_expected.to allow_values("12/12", '01/17', '12/18', '08/25').for(:expires)
      end

      it do
        is_expected.not_to allow_values("13/13", "00/13", '17/12').for(:expires)
      end
    end

    it { is_expected.to validate_presence_of(:name) }
    context 'with invalid attributes' do
      it do
        is_expected.to allow_values("Eugene Test", 'Teest das', 'qqa ss', 'Urb sad')
              .for(:name)
      end

      it do
        is_expected.not_to allow_values("--123", "    ", 'lol--', '12345 das', 'aas1 11s', 's' * 51)
                  .for(:name)
      end
    end

    it { is_expected.to validate_presence_of(:number) }
    context 'with invalid attributes' do
      it do
        is_expected.to allow_values('1234123412341234').for(:number)
      end

      it do
        is_expected.not_to allow_values('aasdasdfasdfasdf', 'asdf123412341234', '123123')
                  .for(:number)
      end
    end


  end
end
