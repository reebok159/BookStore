describe "Some user actions", :type => :feature do
  before :each do
    create(:user, email: "tsets@ss.ss", password: "12345678q")
    login("tsets@ss.ss", "12345678q")
  end

  it "signs me in" do
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(page).to have_link I18n.t('pages.myaccount')
  end

  context 'get started' do
    it "show message" do
      click_link "Get Started"
      expect(page).to have_content I18n.t('mainpage.welcome1')
    end
  end
end
