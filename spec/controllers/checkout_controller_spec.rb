require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }

  describe '#show' do
    context 'when user no auth' do
      it 'redirect to log in page if no auth' do
        get :show, params: { id: :address }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user logged in' do
      before(:each) do
        sign_in user
      end

      it 'redirect to cart if order_items is blank' do
        get :show, params: { id: :address }
        expect(response).to redirect_to(cart_page_path)
      end

      it 'show message in cart when order_items is blank' do
        get :show, params: { id: :address }
        expect(flash[:alert]).to match I18n.t('checkout.emptycart')
      end

      it 'redirect to cart page' do
        order_item = create(:order_item, book: create(:book))
        user.orders.first.order_items << order_item
        order.save
        get :show, params: { id: :address }
        expect(response).to render_template(:address)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
