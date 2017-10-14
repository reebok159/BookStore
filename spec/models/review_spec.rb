require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
    #consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~.
    #less than 500 chars

    it { should validate_presence_of(:title) }
    #consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~.
    #less than 80 chars

  end
end
