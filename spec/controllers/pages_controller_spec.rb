require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "Pages methods" do

    it "open main page" do
      get :index
      expect(response.status).to eq(200)
    end

    it "render main page" do
      get :index
      expect(response).to render_template("index")
    end

  end
end
