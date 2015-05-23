class AlbumsController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_albums, only: [:index, :show]
  before_action :set_album, only: [:edit, :update, :destroy]

  def index
    @entries = [
      "/test/downvote.gif",
      "/test/did+you+fight+this+guy+by+any+chance+_33d2dec72fb5c4751e98273256381f0e.gif",
      "/test/tumblr_lyh9zwsJTg1qifgls.gif",
      "/test/sloth-follow-your-dreams.gif",
      "/test/Popcorn-02-Stephen-Colbert.gif",
      "/test/1948b.gif"
    ]
  end

  def show
    @entries = [
      "/test/sloth-follow-your-dreams.gif",
      "/test/Popcorn-02-Stephen-Colbert.gif",
      "/test/1948b.gif"
    ].shuffle
    @album = Album.find_by_slug params[:id]
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_albums
    @albums = Album.all
  end

  def set_album
    @album = Album.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:name, :user_id)
  end
end
