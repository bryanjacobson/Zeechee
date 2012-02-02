# Copyright 2012 Bryan Lee Jacobson
class CreateScreens < ActiveRecord::Migration
  def self.up
    create_table :screens do |t|
      t.string :title
      t.integer :user_id
      t.integer :topic_id
      t.integer :position

      t.timestamps
    end
    add_index :screens, [:topic_id, :position]
  end

  def self.down
    remove_index :screens, [:topic_id, :position]
    drop_table :screens
  end
end
