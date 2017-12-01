RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancan

  config.model 'Book' do
    exclude_fields :orders, :order_items
  end

  config.model 'Author' do
    exclude_fields :book
  end

  config.model 'InfoBook' do
    visible false
  end

  config.model 'Image' do
    visible false
  end

  config.model 'OrderItem' do
    visible false
  end

  config.model 'CreditCard' do
    visible false
  end

  config.model 'BillingAddress' do
    visible false
  end

  config.model 'BillingAddress' do
    visible false
  end

  config.model 'OrderAddress' do
    visible false
  end

  config.model 'ShippingAddress' do
    visible false
  end


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
