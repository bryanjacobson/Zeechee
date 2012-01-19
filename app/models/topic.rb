class Topic < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict

  belongs_to :user

  has_many :screens, :order => "position", :dependent => :destroy

  acts_as_list

  def scope_condition
    ancestry ? "ancestry = '#{ancestry}'" : 'ancestry IS NULL'
  end
end
