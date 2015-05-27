class AlbumsController < ApplicationController
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_albums, only: [:index, :show]
  before_action :set_album, only: [:edit, :update, :destroy]
  before_action :set_entry, only: [:index, :show]


  def index
    @entries = Entry.sorted
  end

  def show
    @album = get_album
    @entries = @album.entries.sorted
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
        format.html { redirect_to album_path(@album.slug), notice: 'Album was successfully created.' }
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

  def get_album
    @album = Album.where(slug: params[:id]).includes(:entries).first or raise ActiveRecord::RecordNotFound
  end

  def set_entry
    @entry = Entry.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:album).permit(:name, :user_id)
  end
end
