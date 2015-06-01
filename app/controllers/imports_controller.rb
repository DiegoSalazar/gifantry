class ImportsController < ApplicationController
  layout "modal_layout"
  before_action :set_albums
  before_action :set_entry_view, only: :create

  def index
    @album_id = params[:album_id]
  end

  def create
    @importer = Importer.new import_params, current_user.entries

    if @importer.import
      @album = Album.find_by_id import_params[:album_id] # sets the highlighted album in sidenav
      @entries = @album ? @album.entries.sorted.page(params[:page]) : get_entries
    else
      flash.now[:error] = @importer.error
    end
  end

  private

  def import_params
    @import_params ||= params.require(:import).permit :album_id, :urls, files: []
  end
end
