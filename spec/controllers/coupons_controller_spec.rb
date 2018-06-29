# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let(:user) { create(:user) }
  let(:coupon) { create(:coupon, code: 'testcoupon') }

  before(:each) do
    sign_in user
  end

  describe 'POST #create' do
    context 'with empty cart' do
      before(:each) do
        @order = create(:order, user: user)
      end

      it 'try to activate and something happening' do
        post :create, params: { coupon: { code: coupon.code } }
        expect(flash[:alert]).not_to be nil
      end

      it 'check that I cannot use coupon to empty cart' do
        post :create, params: { coupon: { code: coupon.code } }
        expect(flash[:alert]).to eq I18n.t('coupon.cantactivate')
      end
    end

    context 'with cart items' do
      before(:each) do
        @order = create(:order, :with_books, user: user)
      end

      it 'show activate success' do
        post :create, params: { coupon: { code: coupon.code } }
        expect(flash[:notice]).to eq I18n.t('coupon.activatesuccess')
      end

      it 'check that coupon have effect to order sum' do
        post :create, params: { coupon: { code: coupon.code } }
        @order.reload
        expect(@order.coupon_discount).to eq coupon.discount
      end

      it 'try activate expired coupon' do
        expired_coupon = create(:coupon, code: 'testcoupon2', expires: DateTime.now - 5.days)
        post :create, params: { coupon: { code: expired_coupon.code } }
        expect(flash[:alert]).to eq I18n.t('coupon.termerror')
      end

      it 'show that order sum is not enough' do
        coupon = create(:coupon, min_sum_to_activate: @order.subtotal + 1)
        post :create, params: { coupon: { code: coupon.code } }
        expect(flash[:alert]).to eq I18n.t('coupon.sumerror')
      end

      it 'show that coupon is not exist' do
        some_rand_value = '----nasdfjan213sd'
        post :create, params: { coupon: { code: some_rand_value } }
        expect(flash[:alert]).to eq I18n.t('coupon.noexist')
      end
    end
  end
end
