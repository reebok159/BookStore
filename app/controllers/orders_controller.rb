# frozen_string_literal: true

class OrdersController < ApplicationController
  load_and_authorize_resource :order, only: %i[index show]

  def index
    @orders = current_user.orders.completed
                          .select_status(params[:status])
                          .decorate
  end

  def show
    @order = current_user.orders.completed.find(params[:id]).decorate
  end

  def cart
    @order = last_order.decorate
  end
end
