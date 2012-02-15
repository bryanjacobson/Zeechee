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

  def contents_link
    contents = topic
    contents = topic.parent if !topic.is_root?
    return contents
  end

  # Return comments thate are type==6 Notes to self of user_id
  def notes_to_self(user_id)
    Comment.find(:all, :order => "created_at DESC", :conditions => ["commentable_id = ? AND commentable_type = ? AND comment_type = ? AND user_id = ?", id, 'Screen', 6, user_id])
  end

  # Return comments thate are type==5 Feedback written by user_id
  # or all type==5 Feedback if user_id is the author
  def feedback(user_id_param)
    if user_id == user_id_param
      Comment.find(:all, :order => "created_at DESC", :conditions => ["commentable_id = ? AND commentable_type = ? AND comment_type = ?", id, 'Screen', 5])
    else
      Comment.find(:all, :order => "created_at DESC", :conditions => ["commentable_id = ? AND commentable_type = ? AND comment_type = ? AND user_id = ?", id, 'Screen', 5, user_id_param])
    end
  end

  # Return regular comments type < 5
  def regular_comments
    Comment.find(:all, :order => "created_at DESC", :conditions => ["commentable_id = ? AND commentable_type = ? AND comment_type < ?", id, 'Screen', 5])
  end
end
