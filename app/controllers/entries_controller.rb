class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_entry_view, only: :index

  def index
    @albums = current_user.albums
    @entries = get_entries
    @entry = Entry.new
  end

  def show
    render layout: "modal_layout"
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def detail
    render layout: "modal_layout"
  end

  def create
    @entry = current_user.entries.build entry_params

    respond_to do |format|
      if @entry.save!
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json do
          render json: { error: @entry.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  rescue => e
    render json: { error: e.message }, status: :server_error
  end

  def update
    respond_to do |format|
      if @entry.update entry_params
        format.html { redirect_to album_path(@entry.album.slug), notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    name = @entry.display_name
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: "The Entry \"#{name}\" was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_entry
    @entry = current_user.entries.find params[:id]
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
