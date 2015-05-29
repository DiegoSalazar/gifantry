class AddEntriesCountFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :entries_count, :integer, default: 0
  end
end
