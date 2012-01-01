class Item < ActiveRecord::Base
  belongs_to :uset
  belongs_to :content
  acts_as_list :scope => :content
end
