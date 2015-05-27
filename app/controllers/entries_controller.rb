class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_user.albums
    @entries = get_entries
    @entry = Entry.new
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  rescue => e
    render json: { error: e.message }, status: :server_error
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to album_path(@entry.album.slug), notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def get_entries
    if params[:tag_name].present?
      current_user.entries.sorted.tagged_with params[:tag_name]
    else
      current_user.entries.sorted
    end
  end

  def entry_params
    params.require(:entry).permit(
      :name,
      :description,
      :image,
      :album_id,
      :tag_list
    )
  end
end
