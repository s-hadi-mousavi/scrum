class Post < ActiveRecord::Base
  attr_accessible :bubble, :content, :flags_id, :group_id, :name, :project_id, :task_id, :user_id
end
