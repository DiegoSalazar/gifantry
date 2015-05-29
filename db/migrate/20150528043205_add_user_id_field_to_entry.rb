class AddUserIdFieldToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :integer, null: false
    add_index :entries, :user_id
  end
end
