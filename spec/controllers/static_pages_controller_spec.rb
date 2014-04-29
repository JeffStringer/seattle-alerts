require 'spec_helper'

describe StaticPagesController do

  describe "static_pages#main" do
    it "responds successfully with an HTTP 200 status code" do
      get :main
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the main template" do
      get :main
      expect(response).to render_template("main")
    end
  end

  describe "static_pages#about" do
    it "responds successfully with an HTTP 200 status code" do
      get :about
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the about template" do
      get :about
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
end
