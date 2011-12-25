class Content < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  acts_as_list :scope => :topic
end
