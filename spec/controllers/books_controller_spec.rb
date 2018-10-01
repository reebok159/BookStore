# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let!(:book) { create(:book) }

  describe 'GET #index' do
    it 'assigns @books' do
      get :index
      expect(assigns(:books)).to eq([book])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'open page with books' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template('show')
    end

    it 'open page with book' do
      get :show, params: { id: book.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
