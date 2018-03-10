describe 'checkout process', type: :feature do
  let(:billing_address) { attributes_for(:billing_address) }
  let(:shipping_address) { attributes_for(:shipping_address) }
  let(:credit_card) { attributes_for(:credit_card) }

  before :each do
    @book = create(:book)
    @user = create(:user, email: 'tsets@ss.ss', password: '12345678q')
    create(:delivery_method)
    login('tsets@ss.ss', '12345678q')
  end

  it 'should complete order' do
    click_button I18n.t('action.buynow')
    visit cart_page_path
    click_link I18n.t('cart.checkout'), match: :first

    check_content_address_step
    fill_address_form('billing', billing_address)
    fill_address_form('shipping', shipping_address)
    click_button I18n.t('checkout.saveandcontinue')

    check_content_delivery_step
    first('div.form-group span.radio-text').click
    click_button I18n.t('checkout.saveandcontinue')

    check_content_card_step
    invalid_card = { number: '111', expires: '111', name: '111', cvv: '111' }
    fill_card_form(invalid_card) # check invalid
    click_button I18n.t('checkout.saveandcontinue')

    expect(page).to have_content I18n.t('checkout.isinvalid')
    fill_card_form(credit_card)
    click_button I18n.t('checkout.saveandcontinue')

    check_content_confirm_step
    click_link 'Place Order'
    check_content_complete_thanks(@user.email)
  end

  context 'with checkbox "Use billing address"', js: true do
    before :each do
      click_button I18n.t('action.buynow')
      visit cart_page_path
      click_link 'Checkout', match: :first
    end

    it 'should complete order' do
      check_content_address_step
      fill_address_form('billing', billing_address)
      find('[name=use_billing] + span.checkbox-icon').click
      click_button I18n.t('checkout.saveandcontinue')

      check_content_delivery_step
      first('div.form-group span.radio-text').click
      click_button I18n.t('checkout.saveandcontinue')

      check_content_card_step
      fill_card_form(credit_card)
      click_button I18n.t('checkout.saveandcontinue')

      check_content_confirm_step
      click_link 'Place Order'

      check_content_complete_thanks(@user.email)
    end

    context 'with editins in confirm step' do
      it 'should complete order' do
        check_content_address_step
        fill_address_form('billing', billing_address)
        find('[name=use_billing] + span.checkbox-icon').click
        click_button I18n.t('checkout.saveandcontinue')

        check_content_delivery_step
        first('div.form-group span.radio-text').click
        click_button I18n.t('checkout.saveandcontinue')

        check_content_card_step
        fill_card_form(credit_card)
        click_button I18n.t('checkout.saveandcontinue')

        expect(page).to have_content 'Shipping Address'
        first('a.general-edit', text: 'edit').click
        expect(page).to have_content I18n.t('checkout.address.billaddress')
        expect(page).to have_content 'all fields are required'
        fill_in 'order[billing_address_attributes][first_name]', with: 'Mike'
        find('[name=use_billing] + span.checkbox-icon').click
        click_button I18n.t('checkout.saveandcontinue')
        check_content_confirm_step
        click_link 'Place Order'

        check_content_complete_thanks(@user.email)
      end
    end
  end
end
