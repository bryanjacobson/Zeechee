class RenameItemColumn < ActiveRecord::Migration
  def self.up
    rename_column :items, :content_id, :screen_id
  end

  def self.down
    rename_column :items, :screen_id, :content_id 
  end
end
