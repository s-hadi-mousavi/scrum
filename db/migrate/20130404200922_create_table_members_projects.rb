class CreateTableMembersProjects < ActiveRecord::Migration
  create_table :members_projects, :id => false do |t|
    t.references :user, :null => false
    t.references :project, :null => false
  end
end
