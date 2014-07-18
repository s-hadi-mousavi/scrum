class Task < ActiveRecord::Base
  attr_accessible :description, :parent_id, :project_id, :group_id
  belongs_to :project
  # Parent id is id of parent TASK
  has_many :tasks, :foreign_key => "parent_id"
  belongs_to :task
  has_and_belongs_to_many :users
  has_and_belongs_to_many :languages
  has_many :trequests
  belongs_to :group
end
