require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let(:book) { create(:book) }

  describe 'order_items controller' do
    context 'POST #create' do
      before(:each) do
        sign_in user
      end

      it 'add item to order' do
        _quantity = 1
        post :create, params: { order_item: { item_id: book.id, quantity: _quantity } }
        expect(flash[:notice]).to match I18n.t('order_item.create_success')
        order.reload
        expect(order.order_items.first.item_id).to eq book.id
        expect(order.order_items.first.quantity).to eq _quantity
      end

      it 'found the same item and only change count' do
        _quantity = 1
        _added_val = 3
        post :create, params: { order_item: { item_id: book.id, quantity: _quantity } }
        order.reload

        expect(order.order_items.first.item_id).to eq book.id
        expect(order.order_items.first.quantity).to eq _quantity

        post :create, params: { order_item: { item_id: book.id, quantity: _added_val } }
        order.reload
        expect(order.order_items.first.item_id).to eq book.id
        expect(order.order_items.first.quantity).to eq (_quantity + _added_val)
      end

      it 'should not add item to order' do
        _quantity = 1
        rand_id = '-1232352'
        post :create, params: { order_item: { item_id: rand_id, quantity: _quantity } }
        expect(flash[:notice]).to match I18n.t('order_item.create_fail')
        order.reload
        expect(order.order_items.size).to be_zero
      end
    end

    context 'PATCH #update' do
      before(:each) do
        sign_in user
        @order_item = create(:order_item, book: book)
        order.order_items << @order_item
        order.save
      end

      it 'change quantity item' do
        _new_quantity = @order_item.quantity + 5
        patch :update, params: { id: @order_item.id, order_item: { quantity: _new_quantity } }
        order.reload
        expect(order.order_items.first.quantity).to eq(_new_quantity)
      end

      it 'should not change quantity' do
        rand_id = '-1232352'
        patch :update, params: { id: rand_id, order_item: { quantity: 1 } }
        expect(flash[:alert]).to match I18n.t('order_item.update_fail')
      end

      it 'set quantity to 1 if new value is not valid' do
        invalid_value = -7
        patch :update, params: { id: @order_item.id, order_item: { quantity: invalid_value } }
        order.reload
        expect(order.order_items.first.quantity).to eq 1
      end
    end

    context 'DELETE #destroy' do
      before(:each) do
        sign_in user
        @order_item = create(:order_item, book: create(:book))
        @order_item2 = create(:order_item, book: create(:book))
        order.order_items << @order_item
        order.order_items << @order_item2
        order.save
      end

      it 'remove item' do
        delete :destroy, params: { id: @order_item.id }
        order.reload
        expect(order.order_items.size).to be 1
        expect(order.order_items).to exist(@order_item2.id)
      end
    end
  end
end
