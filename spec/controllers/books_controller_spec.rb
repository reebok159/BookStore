require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET request" do
    it "assigns @books" do
      book = FactoryGirl.create(:book)
      get :index
      expect(assigns(:books)).to eq([book])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders the show template" do
      book = FactoryGirl.create(:book)
      get :show, params: { :id => book.id }
      expect(response).to render_template("show")
    end

    it "redirect to books index" do
      get :catalog
      expect(response).to redirect_to(books_url)
    end

    it "redirect to books index with message" do
      get :catalog
      expect(flash[:notice]).to match I18n.t('mainpage.welcome1')+' '+I18n.t('mainpage.welcome2')
    end

  end
end
