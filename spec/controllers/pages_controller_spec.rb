require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'Pages methods' do
    before { get :index }

    it 'open main page' do
      expect(response).to have_http_status(:ok)
    end

    it 'render main page' do
      expect(response).to render_template('index')
    end
  end
end
