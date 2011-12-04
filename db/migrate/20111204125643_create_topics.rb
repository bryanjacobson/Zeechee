class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :icon
      t.string :ancestry

      t.timestamps
    end
    add_index :topics, :ancestry
  end

  def self.down
    remove_index :topics, :ancestry
    drop_table :topics
  end
end
