describe "checkout process", :type => :feature do
  before :each do
    @book = create(:book)
    @user = create(:user, email: "tsets@ss.ss", password: "12345678q")
    create(:delivery_method)
    login("tsets@ss.ss", "12345678q")
  end

  it 'should complete order' do
    #login("tsets@ss.ss", "12345678q")
    click_button 'Buy Now'
    visit cart_page_path
    click_link "Checkout", match: :first

    expect(page).to have_content 'Billing Address'
    fill_in 'order[billing_address_attributes][first_name]', with: "Eugene"
    fill_in 'order[billing_address_attributes][last_name]', with: "Tester"
    fill_in 'order[billing_address_attributes][address]', with: "Gagarina 18"
    fill_in 'order[billing_address_attributes][city]', with: "Dnipro"
    fill_in 'order[billing_address_attributes][zip]', with: "50001"
    page.select 'Ukraine', :from => 'order[billing_address_attributes][country]'
    fill_in 'order[billing_address_attributes][phone]', with: "+380504567895"

    fill_in 'order[shipping_address_attributes][first_name]', with: "Eugene"
    fill_in 'order[shipping_address_attributes][last_name]', with: "Tester"
    fill_in 'order[shipping_address_attributes][address]', with: "Pravda 53"
    fill_in 'order[shipping_address_attributes][city]', with: "Dnipro"
    fill_in 'order[shipping_address_attributes][zip]', with: "53001"
    page.select 'Ukraine', :from => 'order[shipping_address_attributes][country]'
    fill_in 'order[shipping_address_attributes][phone]', with: "+380504567895"
    click_button 'Save and Continue'

    expect(page).to have_content 'Delivery Method'
    first('div.form-group span.radio-text').click
    click_button 'Save and Continue'

    expect(page).to have_content 'Credit Card'
    #check invalid
    fill_in 'order[credit_card_attributes][number]', with: '111'
    fill_in 'order[credit_card_attributes][expires]', with: '111'
    fill_in 'order[credit_card_attributes][name]', with: '111'
    fill_in 'order[credit_card_attributes][cvv]', with: '111'
    click_button 'Save and Continue'
    expect(page).to have_content 'is invalid'
    fill_in 'order[credit_card_attributes][number]', with: '1111222233334444'
    fill_in 'order[credit_card_attributes][expires]', with: '11/21'
    fill_in 'order[credit_card_attributes][name]', with: 'Eugene V'
    fill_in 'order[credit_card_attributes][cvv]', with: '123'
    click_button 'Save and Continue'
    expect(page).to have_content 'Shipping Address'
    expect(page).to have_content 'Billing Address'
    expect(page).to have_content 'Shipments'
    expect(page).to have_content 'Payment Information'
    expect(page).to have_content 'edit'
    click_link 'Place Order'
    expect(page).to have_content I18n.t('checkout.thanks')
    expect(page).to have_content I18n.t('checkout.thanks2', email: @user.email)
  end

  context 'with checkbox "Use billing address"', js: true do
    before :each do
      click_button 'Buy Now'
      visit cart_page_path
      click_link "Checkout", match: :first
    end

    it 'should complete order' do
      expect(page).to have_content 'Billing Address'
      fill_in 'order[billing_address_attributes][first_name]', with: "Eugene"
      fill_in 'order[billing_address_attributes][last_name]', with: "Tester"
      fill_in 'order[billing_address_attributes][address]', with: "Gagarina 18"
      fill_in 'order[billing_address_attributes][city]', with: "Dnipro"
      fill_in 'order[billing_address_attributes][zip]', with: "50001"
      page.select 'Ukraine', :from => 'order[billing_address_attributes][country]'
      fill_in 'order[billing_address_attributes][phone]', with: "+380504567895"

      find('[name=use_billing] + span.checkbox-icon').click
      click_button 'Save and Continue'

      expect(page).to have_content 'Delivery Method'
      first('div.form-group span.radio-text').click
      click_button 'Save and Continue'

      expect(page).to have_content 'Credit Card'
      fill_in 'order[credit_card_attributes][number]', with: '1111222233334444'
      fill_in 'order[credit_card_attributes][expires]', with: '11/21'
      fill_in 'order[credit_card_attributes][name]', with: 'Eugene V'
      fill_in 'order[credit_card_attributes][cvv]', with: '123'
      click_button 'Save and Continue'

      expect(page).to have_content 'Shipping Address'
      expect(page).to have_content 'Billing Address'
      expect(page).to have_content 'Shipments'
      expect(page).to have_content 'Payment Information'
      expect(page).to have_content 'edit'
      click_link 'Place Order'

      expect(page).to have_content I18n.t('checkout.thanks')
      expect(page).to have_content I18n.t('checkout.thanks2', email: @user.email)
    end

    context 'with editins in confirm step' do
      it 'should complete order' do
        expect(page).to have_content 'Billing Address'
        fill_in 'order[billing_address_attributes][first_name]', with: "Eugene"
        fill_in 'order[billing_address_attributes][last_name]', with: "Tester"
        fill_in 'order[billing_address_attributes][address]', with: "Gagarina 18"
        fill_in 'order[billing_address_attributes][city]', with: "Dnipro"
        fill_in 'order[billing_address_attributes][zip]', with: "50001"
        page.select 'Ukraine', :from => 'order[billing_address_attributes][country]'
        fill_in 'order[billing_address_attributes][phone]', with: "+380504567895"

        find('[name=use_billing] + span.checkbox-icon').click
        click_button 'Save and Continue'

        expect(page).to have_content 'Delivery Method'
        first('div.form-group span.radio-text').click
        click_button 'Save and Continue'

        expect(page).to have_content 'Credit Card'
        fill_in 'order[credit_card_attributes][number]', with: '1111222233334444'
        fill_in 'order[credit_card_attributes][expires]', with: '11/21'
        fill_in 'order[credit_card_attributes][name]', with: 'Eugene V'
        fill_in 'order[credit_card_attributes][cvv]', with: '123'
        click_button 'Save and Continue'

        expect(page).to have_content 'Shipping Address'
        first('a.general-edit', text: 'edit').click
        expect(page).to have_content 'Billing Address'
        expect(page).to have_content 'all fields are required'
        fill_in 'order[billing_address_attributes][first_name]', with: "Mike"
        find('[name=use_billing] + span.checkbox-icon').click
        click_button 'Save and Continue'
        expect(page).to have_content 'Shipping Address'
        expect(page).to have_content 'Billing Address'
        expect(page).to have_content 'Shipments'
        expect(page).to have_content 'Payment Information'
        expect(page).to have_content 'edit'
        click_link 'Place Order'

        expect(page).to have_content I18n.t('checkout.thanks')
        expect(page).to have_content I18n.t('checkout.thanks2', email: @user.email)
      end
    end
  end
end
