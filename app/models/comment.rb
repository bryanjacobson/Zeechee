# Copyright 2012 Bryan Lee Jacobson
class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :comments, :as => :commentable
  validates_size_of :content, :within => 1..560

  def comment_types
    [ ["Comment", 1],
      ["Question", 2],
      ["Answer", 3],
      ["Answered Question", 4],
      ["Feedback to Author", 5],
      ["Note to Self", 6],
    ]
  end
end
