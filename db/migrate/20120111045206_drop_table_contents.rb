# Copyright 2012 Bryan Lee Jacobson
class DropTableContents < ActiveRecord::Migration
  def self.up
    remove_index :contents, [:topic_id, :position]
    drop_table :contents
  end

  def self.down
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :position
      t.string :icon
      t.string :icon_credit
      t.integer :topic_id

      t.timestamps
    end
    add_index :contents, [:topic_id, :position]
  end
end
