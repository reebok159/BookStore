require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe '#start' do
    context 'when user no auth' do
      before(:each) do
        @order = FactoryGirl.create(:order)
        @order_item = FactoryGirl.create(:order_item, book: FactoryGirl.create(:book))
        @order.order_items << @order_item
        @order.save
        cookies.signed[:order_id] = @order.id
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
        @order = FactoryGirl.create(:order)
        @order_item = FactoryGirl.create(:order_item, book: FactoryGirl.create(:book))
        @order.order_items << @order_item
        @order.save
        cookies.signed[:order_id] = @order.id
        cookies[:save_cart] = true
        get :index
        @order.reload
        expect(@order.user_id).to eq user.id
        expect(assigns(:order).id).to eq @order.id
      end

      context 'from comfirm step' do
        xit 'set flash[:return_to_confirm] if we try to edit address' do
          @order = FactoryGirl.create(:order, user: user)
          @order_item = FactoryGirl.create(:order_item, book: FactoryGirl.create(:book))
          @order.order_items << @order_item
          @order.checkout_state = 'confirm'
          @order.save
          get :index
          expect(response).to render_template('test')
        end

        xit 'open address partial to edit'

        it 'return to confirm page after address editing' do
          cookies[:return_to_confirm] = true
          allow(controller).to receive(:processing_address).and_return(:success)
          get :next_stage
          expect(assigns(:order).checkout_state).to eq 'confirm'
        end
      end
    end
  end
end
