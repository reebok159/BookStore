# frozen_string_literal: true

module FeatureHelper
  def login(email, password)
    visit root_path
    first(:link, 'Log In').click
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_button 'Log In'
  end

  def fill_address_form(type, data)
    fill_in "order[#{type}_address][first_name]", with: data[:first_name]
    fill_in "order[#{type}_address][last_name]", with: data[:last_name]
    fill_in "order[#{type}_address][address]", with: data[:address]
    fill_in "order[#{type}_address][city]", with: data[:city]
    fill_in "order[#{type}_address][zip]", with: data[:zip]
    page.select data[:country], from: "order[#{type}_address][country]"
    fill_in "order[#{type}_address][phone]", with: data[:phone]
  end

  def fill_card_form(data)
    fill_in 'order[credit_card][number]', with: data[:number]
    fill_in 'order[credit_card][expires]', with: data[:expires]
    fill_in 'order[credit_card][name]', with: data[:name]
    fill_in 'order[credit_card][cvv]', with: data[:cvv]
  end

  def check_content_address_step
    expect(page).to have_content I18n.t('checkout.address.billaddress')
  end

  def check_content_delivery_step
    expect(page).to have_content I18n.t('checkout.delivery.dmethod')
  end

  def check_content_card_step
    expect(page).to have_content I18n.t('checkout.payment.creditcard')
  end

  def check_content_confirm_step
    expect(page).to have_content I18n.t('checkout.address.shaddress')
    expect(page).to have_content I18n.t('checkout.address.billaddress')
    expect(page).to have_content I18n.t('checkout.confirm.shipments')
    expect(page).to have_content I18n.t('checkout.confirm.paymentinfo')
    expect(page).to have_content I18n.t('checkout.confirm.edit')
  end

  def check_content_complete_thanks(email)
    expect(page).to have_content I18n.t('checkout.thanks')
    expect(page).to have_content I18n.t('checkout.thanks2', email: email)
  end
end
