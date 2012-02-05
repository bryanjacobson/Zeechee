# Copyright 2012 Bryan Lee Jacobson
class Topic < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict

  belongs_to :user

  has_many :screens, :order => "position", :dependent => :destroy

  has_many :comments, :as => :commentable

  acts_as_list

  def scope_condition
    ancestry ? "ancestry = '#{ancestry}'" : 'ancestry IS NULL'
  end

  # Needed to update list position when moving to different ancestry
  def parent=(new_parent)
    if parent != new_parent
      p = position
      remove_from_list if (p && valid?)
      super
      add_to_list_bottom if (p && valid?)
    else
      super
    end
  end

  def authorized?(current_user)
    return true if current_user == user
    return true if !is_root? && current_user == parent.user
    return false
  end

  # When traversing screens first, my screens
  def first_screen
    # print "frst: " + id.to_s + " - " + title + "\n"
    return screens.first if !screens.empty?
    next_screen
  end

  # Call "next_screen" when my own screens are done
  def next_screen
    # print "nxt: " + id.to_s + " - " + title + "\n"
    return children.all(:order => :position).first.first_screen if has_children?
    sibling_screen
  end

  def sibling_screen
    # print "sib: " + id.to_s + " - " + title + "\n"
    if !has_siblings? || !lower_item
      return nil if is_root? 
      return parent.sibling_screen
    end
    lower_item.first_screen
  end

  # Generally: Moving to previous screens is tricky
  # When moving backward (previous button) traverse children topics first,
  #    and then my own screens last.

  # previous_screen
  # Situation: 1. My first screen calls my previous screen
  # Action: If I have siblings, ask for their last_screen
  #         If I *don't* have siblings, ask for my parent_last_screen
  def previous_screen
    # print "previous_screen: " + id.to_s + " - " + title + "\n"
    if !has_siblings? || !higher_item
      return nil if is_root?
      return parent.parent_last_screen
    end
    higher_item.last_screen
  end

  # last_screen
  # Situation: 1. My (later) sibling wants my last screen
  # Action: If I have children, ask for their last screen
  #         If I don't, ask for my parent_last_screen
  def last_screen
    # print "last_screen: " + id.to_s + " - " + title + "\n"
    return children.all(:order => :position).last.last_screen if has_children?
    parent_last_screen
  end

  # parent_last_screen
  # Situation: 1. My children are done showing their screens
  #            2. I don't have children
  # Action: If I have screens, show the last one.
  #         If I don't, ask for my previous_screen
  def parent_last_screen
    # print "parent_last_screen: " + id.to_s + " - " + title + "\n"
    return screens.last if !screens.empty?
    previous_screen 
  end
end
