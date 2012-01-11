class Topic < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict

  belongs_to :user

  has_many :screens, :order => "position", :dependent => :destroy
end
