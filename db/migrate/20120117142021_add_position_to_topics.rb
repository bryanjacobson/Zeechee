class AddPositionToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :position, :integer
    add_index :topics, [:ancestry, :position]
  end

  def self.down
    remove_index :topics, [:ancestry, :position]
    remove_column :topics, :position
  end
end
