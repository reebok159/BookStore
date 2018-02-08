require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET request' do
    it 'assigns @books' do
      book = create(:book)
      get :index
      expect(assigns(:books)).to eq([book])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'renders the show template' do
      book = create(:book)
      get :show, params: { id: book.id }
      expect(response).to render_template('show')
    end
  end
end
