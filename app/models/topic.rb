class Topic < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict

  belongs_to :user

  has_many :screens, :order => "position", :dependent => :destroy

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
end
