class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def edit
    #@user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)

      #if @user.changed?
        flash[:notice] = "User was updated"
      #else
        #flash[:notice] = "Nothing was updated"
      #end

      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Data cannot be saved"
      render :settings
    end
  end

  def update_password
    @user = current_user
    if @user.update_with_password(password_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to users_settings_path, flash: { notice: "Successfully updated password" }
    else
      flash[:notice] = "Error. Password cannot be saved"
      render :settings
    end

  end

  def delete_account

  end


  def settings
    @user = current_user
    @billing_address = @user.billing_address || @user.build_billing_address
    @shipping_address = @user.shipping_address || @user.build_shipping_address
  end

  def orders
    #ORDERS
  end

  private

    def user_params
      params.require(:user).permit(:id, :email,
                            billing_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone],
                            shipping_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone])
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
