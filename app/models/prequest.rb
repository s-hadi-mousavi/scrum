class Prequest < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :user_id, :scope => [:project_id]
end
