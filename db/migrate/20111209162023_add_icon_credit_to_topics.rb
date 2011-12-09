class AddIconCreditToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :icon_credit, :string
  end

  def self.down
    remove_column :topics, :icon_credit
  end
end
