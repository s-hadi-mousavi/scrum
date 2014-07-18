class AddIndexToMembersProjects < ActiveRecord::Migration
  def change
    add_index :members_projects, [ :user_id, :project_id ], :unique => true, :name => 'by_member_and_project'
    add_index :mods_projects, [ :user_id, :project_id ], :unique => true, :name => 'by_mod_and_project'
  end
end
