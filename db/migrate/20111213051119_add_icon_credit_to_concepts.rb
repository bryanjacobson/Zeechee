class AddIconCreditToConcepts < ActiveRecord::Migration
  def self.up
    add_column :concepts, :icon_credit, :string
  end

  def self.down
    remove_column :concepts, :icon_credit
  end
end
