# Copyright 2012 Bryan Lee Jacobson
class Screen < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :items, :order => "position", :dependent => :destroy
  has_many :comments, :as => :commentable
  acts_as_list :scope => :topic
  validates_size_of :title, :within => 1..280

  def authorized?(current_user)
    return true if current_user == user
    return true if current_user == topic.user
    return false
  end

  def next_screen
    return lower_item if lower_item
    topic.next_screen
  end

  def previous_screen
    return higher_item if higher_item
    topic.previous_screen
  end
end
