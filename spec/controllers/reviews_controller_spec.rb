require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  #create book before
  #auth user
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  describe '#create' do
    before(:each) do
      sign_in user
    end

    it 'save review with success message' do
      put :create, params: { review: { book_id: book.id, text: 'Some text', title: 'Mike', rating: 5 }}
      expect(flash[:notice]).to match I18n.t('reviews.createsuccess')
    end

    it 'check user is auth' do
      sign_out user
      put :create, params: { review: { book_id: book.id, text: 'Some text', title: 'Mike', rating: 5 }}
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'show error message after trying to save to invalid book' do
      invalid_id = "-24541234"
      put :create, params: { review: { book_id: invalid_id, text: 'Some text', title: 'Mike', rating: 5 }}
      expect(flash[:alert]).to match I18n.t('reviews.createfail')
    end
  end
end
