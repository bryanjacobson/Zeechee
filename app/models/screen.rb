class Screen < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :items, :order => "position", :dependent => :destroy
  acts_as_list :scope => :topic
  validates_size_of :title, :within => 1..280

  def next_screen
    return lower_item if lower_item
    topic.next_screen
  end
end
