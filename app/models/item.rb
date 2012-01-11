class Item < ActiveRecord::Base
  belongs_to :uset
  belongs_to :screen
  acts_as_list :scope => :screen

  def item_types
    [ ["Auto Detect", 1],
      ["Text", 2],
      ["Image", 3]
    ]
  end
end
