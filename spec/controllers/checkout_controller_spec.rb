require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  describe '#start' do
    context 'when user no auth' do
      it 'set cookie :save_cart to true'
      it 'redirect to log in page'
    end

    context 'when user logged in' do
      it 'open first checkout step'
    end
  end

  describe '#index' do
    it 'redirect to cart if order_items is blank'
    it 'show message in cart when order_items is blank'

    context 'when user loggen in' do
      it 'move cart to current user if :save_cart cookie is true'

      context 'from comfirm step' do
        it 'set flash[:return_to_confirm] if we try to edit address'
        it 'open address partial to edit'
        it 'return to confirm page after address editing'
      end
    end
  end
end
