require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe '#create' do
    before(:each) do
      sign_in user
    end

    it 'save review with success message' do
      post :create, params: { review: attributes_for(:review, book_id: book.id) }
      expect(flash[:notice]).to match I18n.t('reviews.createsuccess')
    end

    it 'check user is auth' do
      sign_out user
      post :create, params: { review: attributes_for(:review, book_id: book.id) }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'show error message after trying to save to invalid book' do
      invalid_id = "-24541234"
      post :create, params: { review: attributes_for(:review, book_id: invalid_id) }
      expect(flash[:alert]).to match I18n.t('reviews.createfail')
    end
  end
end
