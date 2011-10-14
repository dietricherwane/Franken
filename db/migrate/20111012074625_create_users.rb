class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :phone_number
      t.string :gender
      t.string :area
      t.text :exclusion_list

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end

end
