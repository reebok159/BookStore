class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = t('users.updatesuccess')
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = t('users.updatefail')
      render :settings
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(password_params)
      bypass_sign_in @user
      redirect_to settings_users_path, flash: { notice: t('users.updpasssuccess') }
    else
      flash[:notice] = t('users.updpassfail')
      render :settings
    end
  end

  def settings
    @user = current_user
    @billing_address = @user.billing_address || @user.build_billing_address
    @shipping_address = @user.shipping_address || @user.build_shipping_address
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
