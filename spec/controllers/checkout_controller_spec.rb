require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order) }

  describe '#start' do
    context 'when user no auth' do
      before(:each) do
        @order_item = create(:order_item, book: create(:book))
        order.order_items << @order_item
        order.save
        cookies.signed[:order_id] = order.id
      end

      it 'set cookie :save_cart to true' do
        get :start
        expect(cookies[:save_cart]).to eq 'true'
      end

      it 'redirect checkout page' do
        get :start
        expect(response).to redirect_to(checkout_path)
      end
    end
  end

  describe '#index' do
    context 'when user no auth' do
      it 'redirect to log in page if no auth' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user logged in' do
      before(:each) do
        sign_in user
      end

      it 'redirect to cart if order_items is blank' do
        get :index
        expect(response).to redirect_to(cart_page_path)
      end

      it 'show message in cart when order_items is blank' do
        get :index
        expect(flash[:alert]).to match I18n.t('checkout.emptycart')
      end

      it 'move cart to current user if :save_cart cookie is true' do
        @order_item = create(:order_item, book: create(:book))
        order.order_items << @order_item
        order.save
        cookies.signed[:order_id] = order.id
        cookies[:save_cart] = true
        get :index
        order.reload
        expect(order.user_id).to eq user.id
        expect(assigns(:order).id).to eq order.id
      end
    end
  end
end
