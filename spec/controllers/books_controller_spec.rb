require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET request" do
    #it "assigns @book" do
    #  book = Book.create
    #   get :show, params: { :id => "1" }
    #  expect(assigns(:book)).to eq([book])
    #end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    xit "renders the show template" do
      @book = file_fixture("books.yml").read
      get :show, params: { :id => @book.id }
      expect(response).to render_template("show")
    end

    xit "renders the edit template" do
      get :edit
      expect(response).to render_template("edit")
    end
  end
end
