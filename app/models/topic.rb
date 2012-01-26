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

  def first_screen
    return screens.first if !screens.empty?
    next_screen
  end

  def next_screen
    return children.first.first_screen if has_children?
    sibling_screen
  end

  def sibling_screen
    if !siblings || self == sibling.last
      return nil if is_root? 
      return parent.sibling_screen
    end
    nil # Not done - need to find next sibling
  end
end
