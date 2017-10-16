require 'rails_helper'

RSpec.describe ShortenUrlsController, type: :controller do

  describe "show home page" do

    it "should render show template" do
      get :show
      expect(response).to render_template("show")
    end

    it "assign a new shorten url to res" do
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

    it "should increase the count if url is valid and with params" do
      @shorten_url_params = { url: 'http://www.amazon.com/Kindle-Wireless-Reading-Display-Globally/dp/
       B003FSUDM4/
       ref=amb_link_353259562_2?pf_rd_m=ATVPDKIK X0DER&pf_rd_s=center-10&pf_rd_r=11EYKTN682A79T370AM3&pf_rd_t=201&pf_rd_p=1270985982&pf_rd_i=B002Y27P3M ' }
      expect {
        post :create, params: { shorten_url: @shorten_url_params }
      }.to change(ShortenUrl, :count).by(1)
    end

    it "should render shorten js template" do
      @shorten_url_params = { url: 'http://www.test.com' }
      post :create, params: { shorten_url: @shorten_url_params }, :format => "js"
      expect(response).to render_template("shorten_urls/shorten")
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

    it "should redirect to root if wrong url is given" do
      get :fetch_page, params: { url: 'test' }
      response.should redirect_to root_path
    end

    it "should flash danger if wrong url is given" do
      get :fetch_page, params: { url: 'test' }
      expect(flash[:danger]).to match(I18n.t("url_doesnt_exist"))
    end

  end
end