# frozen_string_literal: true

class OrdersController < ApplicationController
  load_and_authorize_resource only: %i[index show]

  def index
    @orders = @orders.select_status(params[:status]).decorate
  end

  def show
    @order = @order.decorate
  end

  def cart
    @order = last_order.decorate
  end
end
