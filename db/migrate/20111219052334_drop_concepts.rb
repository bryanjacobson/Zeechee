# Copyright 2012 Bryan Lee Jacobson
class DropConcepts < ActiveRecord::Migration
  def self.up
    remove_index :concepts, [:topic_id, :ancestry]
    remove_index :concepts, :ancestry
    drop_table :concepts
  end

  def self.down
    create_table :concepts do |t|
      t.string :icon
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :topic_id
      t.string :ancestry
      t.integer :position
      t.string :icon_credit

      t.timestamps
    end
    add_index :concepts, :ancestry
    add_index :concepts, [:topic_id, :ancestry]
  end
end
