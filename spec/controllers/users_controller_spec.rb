require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #user create
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'PATCH #update_password' do
    it 'update password success' do
      patch :update_password, params: { user: { current_password: '12345678', password: '55555555', password_confirmation: '55555555' } }
      expect(flash[:notice]).to match I18n.t('users.updpasssuccess')
    end

    it 'must show error (passwords is not the same)' do
      patch :update_password, params: { user: {current_password: '12345678', password: '55555555', password_confirmation: '5554' } }
      expect(flash[:notice]).to match I18n.t('users.updpassfail')
    end
  end

  describe 'PUT #update' do
    it 'update user success' do
      new_mail = 'test@tt.kk'
      put :update, params: { id: user.id, user: { email: new_mail } }
      user.reload
      expect(user.email).to eq new_mail
    end

    it 'show success message' do
      new_mail = 'test@tt.kk'
      put :update, params: { id: user.id, user: { email: new_mail } }
      user.reload
      expect(flash[:notice]).to match I18n.t('users.updatesuccess')
    end

    it 'should not save invalid data to user and show error' do
      invalid_mail = ''
      put :update, params: { id: user.id, user: { email: invalid_mail } }
      user.reload
      expect(user.email).not_to eq invalid_mail
      expect(flash[:notice]).to match I18n.t('users.updatefail')
    end
  end
end
