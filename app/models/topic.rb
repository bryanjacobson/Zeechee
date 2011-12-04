class Topic < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict
end
