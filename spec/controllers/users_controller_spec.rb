require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #user create

  context 'PATCH #update_password' do
    it 'update password success'
    it 'must show error (passwords is not the same)'
  end

  context 'PUT #update' do
    it 'update user success'
    it 'show success message'
    it 'should not save invalid data to user and show error'
  end

  context 'DELETE #destroy' do
    it 'returns http success'
    it 'show success message'
  end
end
