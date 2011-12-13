class Concept < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict
  belongs_to :user
  belongs_to :topic
end
