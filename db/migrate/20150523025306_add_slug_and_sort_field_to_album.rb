class AddSlugAndSortFieldToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :slug, :string
    add_column :albums, :sort, :integer, default: 0
  end
end
