# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      return sign_in_via_fb if @user.persisted?

      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end

    def failure
      redirect_to root_path
    end

    private

    def sign_in_via_fb
      sign_in_and_redirect @user, event: :authentication
      save_cart
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end
end
