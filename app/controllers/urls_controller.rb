class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(params.require(:url).permit(:old_url)) # uses a trong parameter to pass the data into the database
    @url.new_url = SecureRandom.base64(6)
    # redirect_to urls_path

    if @url.old_url.include?("http://")|| @url.old_url.include?("https")
      @url.save!
      redirect_to urls_path
    else
      @url.old_url = "http://#{@url.old_url}"
      @url.save!
      redirect_to urls_path
    end

    # if @url.save!
    #   redirect_to urls_path
    # end
  end

  def show
    @url = Url.find(params[:new_url])
    redirect_to @url.old_url
  end
end
