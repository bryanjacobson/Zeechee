class Item < ActiveRecord::Base
  belongs_to :uset
  belongs_to :content
  acts_as_list :scope => :content

  def item_types
    [ ["Auto Detect", 1],
      ["Text", 2],
      ["Image", 3]
    ]
  end
end
