class CreateTableModsProjects < ActiveRecord::Migration
  create_table :mods_projects, :id => false do |t|
    t.references :user, :null => false
    t.references :project, :null => false
  end
end
