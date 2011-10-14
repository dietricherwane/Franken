class AddTrashToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :trash, :text
  end

  def self.down
    remove_column :users, :trash
  end
end
