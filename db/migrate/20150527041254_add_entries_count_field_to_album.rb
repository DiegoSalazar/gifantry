class AddEntriesCountFieldToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :entries_count, :integer, default: 0
  end
end
