describe "Admin panel", :type => :feature do
  before :each do
    allow_any_instance_of(User).to receive(:valid?).and_return(true)
    create(:user, email: "user@t.t", password: "123")
    create(:user, email: "admin@t.t", password: "123", is_admin: true)
  end

  context 'unlogged user' do
    it 'doesn\'t have access' do
      visit rails_admin.dashboard_path
      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

  context 'user' do
    it 'doesn\'t have access' do
      login("user@t.t", "123")
      expect{visit rails_admin.dashboard_path}.to raise_error(CanCan::AccessDenied)
    end
  end

  context 'admin' do
    it 'have access' do
      login("admin@t.t", "123")
      visit rails_admin.dashboard_path
      expect(page).to have_current_path(rails_admin.dashboard_path)
    end
  end

end
