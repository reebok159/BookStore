require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:password) }
    # Minimum 8 letters, at least 1 uppercase, at least 1 lowercase, at least 1 number.
    # Mustn’t contain spaces inside,
    # Spaces at the beginning and at the end should be cut off.

    it { should validate_presence_of(:email) }
    # Has a localpart on the left of an @, the domain on the right. Neither the localpart nor the domain can be empty.
    #The localpart can consist of labels separated by dots but it cannot have two successive dots, nor can it start or end with a dot.
    #Labels consist of a-z, A-Z, 0-9
    #Labels must be less than 63 characters.
    #Labels must not start with a hyphen, end with a hyphen, or contain two successive hyphens.
    #The right-most label must be all alphabetic.

  end
end
