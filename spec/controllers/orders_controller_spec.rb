# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'Orders controller' do
    let(:user) { create(:user) }

    before(:each) do
      sign_in user
    end

    describe 'GET #index' do
      it 'open page with orders' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      context 'with no auth user' do
        it 'open page with orders' do
          sign_out user
          get :index
          expect(response).not_to have_http_status(:ok)
        end
      end
    end

    describe 'GET #show' do
      let(:order) { create(:order, user: user, status: :in_queue) }
      it 'open page with order' do
        get :show, params: { id: order.id }
        expect(response).to have_http_status(:ok)
      end

      context 'with no auth user' do
        it 'open page with orders' do
          sign_out user
          get :show, params: { id: order.id }
          expect(response).not_to have_http_status(:ok)
        end
      end
    end

    describe 'GET #cart' do
      context 'without cart items' do
        before(:each) do
          @order = create(:order, user: user)
          get :cart
        end

        it 'select necessary order' do
          expect(assigns(:order)).to eq(@order)
        end

        it 'open cart' do
          expect(response).to have_http_status(:ok)
        end

        it 'render cart page' do
          expect(response).to render_template('cart')
        end

        it 'check cart is empty' do
          expect(assigns(:order).order_items.count).to eq 0
        end

        it 'check cart isn\'t empty' do
          cart = assigns(:order)
          order_item = create(:order_item, book: create(:book))
          cart.order_items << order_item
          cart.save
          get :cart
          expect(assigns(:order).order_items.count).not_to eq 0
        end
      end

      context 'with cart items' do
        before(:each) do
          @order = create(:order, :with_books, user: user)
          get :cart
        end

        it 'check cart isn\'t empty' do
          expect(assigns(:order).order_items.count).not_to eq 0
        end
      end
    end
  end
end
