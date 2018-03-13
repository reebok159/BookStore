class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :current_user

  def update
    if current_user.update(user_params)
      flash[:notice] = t('users.updatesuccess')
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = t('users.updatefail')
      render :settings
    end
  end

  def update_password
    if current_user.update_with_password(password_params)
      bypass_sign_in current_user
      redirect_to settings_users_path, flash: { notice: t('users.updpasssuccess') }
    else
      flash[:notice] = t('users.updpassfail')
      render :settings
    end
  end

  def settings
    @billing_address = current_user.billing_address || current_user.build_billing_address
    @shipping_address = current_user.shipping_address || current_user.build_shipping_address
  end

  private

  def user_params
    params.require(:user).permit(:id, :email,
                                 billing_address_attributes: %i[first_name last_name address city zip country phone],
                                 shipping_address_attributes: %i[first_name last_name address city zip country phone])
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
