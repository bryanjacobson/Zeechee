class Item < ActiveRecord::Base
  belongs_to :uset
  belongs_to :screen
  acts_as_list :scope => :screen
  before_save :auto_detect

  def item_types
    [ ["Auto Detect", 1],
      ["Text", 2],
      ["Image", 3]
    ]
  end

  private
    def auto_detect
      return if self.item_type_id != 1
      s = self.body.downcase
      if s =~ /\.jpg$/ || s =~ /\.jpeg$/ || s =~ /\.png$/ || s =~ /\.bmp$/ || s =~ /\.gif$/
        self.item_type_id = 3
        return
      end
      self.item_type_id = 2
    end
end
