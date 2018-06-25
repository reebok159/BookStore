# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      save_cart unless current_user.nil?
      super
    end
  end
end
