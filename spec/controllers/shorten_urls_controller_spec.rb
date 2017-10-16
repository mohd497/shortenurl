require 'rails_helper'

RSpec.describe ShortenUrlsController, type: :controller do

  describe "show home page" do

    it "should render show template" do
      get :show
      expect(response).to render_template("show")
    end

    it "assign a new shorten url" do
      get :show
      expect(assigns(:res)).to be_a_new(ShortenUrl)
    end

  end

  describe "create a new short url " do

    it "should increase the count if url is valid" do
      @shorten_url_params = { url: 'http://www.test.com' }
      expect {

        post :create, params: { shorten_url: @shorten_url_params }
      }.to change(ShortenUrl, :count).by(1)
    end

    it "should not increase the count if url is not valid" do
      @shorten_url_params = { url: 'test' }
      expect {

        post :create, params: { shorten_url: @shorten_url_params }
      }.to change(ShortenUrl, :count).by(0)
    end

  end

  describe "fetch page" do

    shorten_url = FactoryGirl.create(:shorten_url)

    it "should redirect to the original url" do
      get :fetch_page, params: { url: shorten_url.unique_key }
      response.should redirect_to 'http://www.test.com'
    end

    it "should redirect to root if wrong url given" do
      get :fetch_page, params: { url: 'test' }
      response.should redirect_to root_path
    end

  end



end