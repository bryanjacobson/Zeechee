# Copyright 2012 Bryan Lee Jacobson
class AddUserIdAndNoteToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :note, :string
    rename_column :items, :options, :style
  end

  def self.down
    remove_column :items, :note
    rename_column :items, :style, :options
  end
end
