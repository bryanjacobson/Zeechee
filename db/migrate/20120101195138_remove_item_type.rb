# Copyright 2012 Bryan Lee Jacobson
class RemoveItemType < ActiveRecord::Migration
  def self.up
      drop_table :item_types
  end

  def self.down
    create_table :item_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
