# frozen_string_literal: true

class AddressForm
  include ActiveModel::Model

  attr_accessor :address, :type

  def initialize(current_user)
    @current_user = current_user
  end

  def update(params)
    @params = params
    @address = build_address
    @address&.save
  end

  def build_address
    @type = address_type
    return unless @type

    @current_user.send(:"build_#{@type}", @params[@type])
  end

  def address_type
    types = %w[billing_address shipping_address]
    @params.keys.find { |item| types.include? item }
  end

  def get_address(type)
    return @address if type == @type

    @current_user.public_send("#{type}_address") || @current_user.public_send("build_#{type}_address")
  end
end
