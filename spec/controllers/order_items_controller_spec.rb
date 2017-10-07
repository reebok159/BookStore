require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe 'order_items controller' do
    context 'POST #create' do
      it 'add item to order'
      it 'found the same item and change count'
      it 'should not add item to order'
    end

    context 'POST #update' do
      it 'change quantity item'
      it 'should not change quantity'
    end

    context 'POST #destroy' do
      it 'clear cart'
      it 'should not clear cart'
      it 'remove item'
      it 'cannot remove invalid item'
    end
  end
end
