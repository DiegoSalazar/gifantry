class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.text :description
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.references :album, index: true

      t.timestamps
    end
  end
end
