require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
      def test
        @last_order = last_order
        render html: 'Hello'
      end
  end

  describe 'Application controller' do
    before(:each) do
      routes.draw { get "test" => "anonymous#test" }
    end

    let(:user) { create(:user) }

    context 'if no auth' do
      it "check last_order is not nil" do
        get :test
        expect(assigns(:last_order)).not_to be nil
      end

      it "check last_order.user is nil if no authorized" do
        get :test
        expect(assigns(:last_order).user).to be nil
      end

      it "check last_order is not try to select invalid order and create new" do
        rand_id = "-234867867867"
        cookies.signed[:order_id] = rand_id
        get :test
        expect(assigns(:last_order)).not_to be nil
      end
    end

    context 'with auth user' do
      it "check last_order.user is not nil if user authorized" do
        sign_in user
        get :test
        expect(assigns(:last_order).user).to eq(user)
      end

      it "unauth and auth user have different orders" do
        get :test
        order1 = assigns(:last_order)
        sign_in user
        get :test
        expect(assigns(:last_order)).not_to eq(order1)
      end
    end
  end
end
