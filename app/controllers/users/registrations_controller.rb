# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :init, only: %i[edit update update_address]

    def update_address
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      if @addr_form.update(address_params)
        flash[:notice] = t('users.updatesuccess')
        redirect_to(edit_user_registration_path) && return
      end
      flash[:notice] = t('users.updatefail')
      render :edit
    end

    private

    def init
      @addr_form = AddressForm.new(current_user)
    end

    def address_params
      params.permit(billing_address: %i[first_name last_name address city
                                        zip country phone],
                    shipping_address: %i[first_name last_name address
                                         city zip country phone])
    end

    protected

    def update_resource(resource, params)
      return resource.update_with_password(params) if params.key?(:current_password)
      resource.update_without_password(params)
    end
  end
end
