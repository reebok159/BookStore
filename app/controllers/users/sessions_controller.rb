# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      save_cart if current_user
      super
    end
  end
end
