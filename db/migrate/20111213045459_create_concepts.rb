class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts do |t|
      t.string :icon
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :topic_id
      t.string :ancestry
      t.integer :position

      t.timestamps
    end
    add_index :concepts, :ancestry
    add_index :concepts, [:topic_id, :ancestry]
  end

  def self.down
    remove_index :concepts, [:topic_id, :ancestry]
    remove_index :concepts, :ancestry
    drop_table :concepts
  end
end
