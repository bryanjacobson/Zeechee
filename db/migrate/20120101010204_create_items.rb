# Copyright 2012 Bryan Lee Jacobson
class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :item_type_id
      t.integer :content_id
      t.integer :position
      t.text :body
      t.string :options
      t.integer :size
      t.integer :user_id

      t.timestamps
    end
    add_index :items, [:content_id, :position]
  end

  def self.down
    remove_index :items, [:content_id, :position]
    drop_table :items
  end
end
