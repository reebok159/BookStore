require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  describe 'ActiveRecord associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:phone) }
    context 'with invalid attributes' do
      it do
        should allow_values("+389552554568", '+380505469878', '+75456987745')
              .for(:phone)
      end

      it do
        should_not allow_values("+311", "    ", '+1'*3, '12345312+312', '12345677', 'sS' * 51)
                  .for(:phone)
      end
    end

    it { should validate_presence_of(:zip) }
    context 'with invalid attributes' do
      it do
        should allow_values("51000", '655545-11', '1234567890')
              .for(:zip)
      end

      it do
        should_not allow_values("+311", "qwer", '--55+', '1' * 11)
                  .for(:zip)
      end
    end

    it { should validate_presence_of(:city) }
    context 'with invalid attributes' do
      it do
        should allow_values("New York", 'Kiev', 'Paris')
              .for(:city)
      end

      it do
        should_not allow_values("_Tdas", "1qwer", 'GASDa12', 'a' * 60, '21312', 'Test-Test')
                  .for(:city)
      end
    end

    it { should validate_presence_of(:address) }
    context 'with invalid attributes' do
      it do
        should allow_values("Gagarina 18, 12", 'Gagarina-test 56', 'Bridon street')
              .for(:address)
      end

      it do
        should_not allow_values("_Tdas", ".1qwer",  'a' * 60, '"dfasd')
                  .for(:address)
      end
    end

    it { should validate_presence_of(:last_name) }
    context 'with invalid attributes' do
      it do
        should allow_values("Gagarin", 'Eugene', 'Bridon')
              .for(:last_name)
      end

      it do
        should_not allow_values("_Tdas", "-1qwer",  'a' * 60, '"dfasd', '123312')
                  .for(:last_name)
      end
    end

    it { should validate_presence_of(:first_name) }
    context 'with invalid attributes' do
      it do
        should allow_values("Gagarin", 'Eugene', 'Bridon')
              .for(:first_name)
      end

      it do
        should_not allow_values("_Tdas", "-1qwer",  'a' * 60, '"dfasd', '123312')
                  .for(:first_name)
      end
    end
  end
end
