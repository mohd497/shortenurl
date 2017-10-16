class ShortenUrlsController < ApplicationController

  def show
    @res = ShortenUrl.new
  end

  def create
    url = ShortenUrl.new(shorten_url_params)

    if url.save
      @res = ShortenUrl.fetch_with_key(url.unique_key, request.base_url)[:shortened_url] #fetch the url from database
    else
      @res = url.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.html
      format.js { render 'shorten_urls/shorten' }
    end
  end

  def fetch_page
    @res = ShortenUrl.fetch_with_key(params[:url], request.base_url)

    if @res
      redirect_to @res[:url] #if correct url redirect to given url
    else
      flash[:danger] = I18n.t('url_doesnt_exist')
      redirect_to root_path #if url not in database or expired redirect to root url
    end
  end

  private
  def shorten_url_params
    params.require(:shorten_url).permit(:url)
  end

end
