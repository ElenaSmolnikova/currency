require 'rails_helper'
RSpec.describe CurrencyRatesController, type: :controller do
  describe "GET index" do
    it "renders :index" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @chart" do
      get :index
      assigns(:chart).not_to be_empty
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
