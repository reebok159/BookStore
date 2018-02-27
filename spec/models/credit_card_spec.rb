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
      let(:year) { Time.now.year.to_s.split(//).last(2).join.to_i }
      it do
        is_expected.to allow_values('12/' << (year + 1).to_s,
                                    '01/' << (year + 5).to_s,
                                    '12/' << (year + 3).to_s,
                                    '08/' << (year + 1).to_s).for(:expires)
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
