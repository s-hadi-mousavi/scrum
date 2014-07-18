class CreateLanguagesProjects < ActiveRecord::Migration
  create_table :languages_projects, :id => false do |t|
    t.references :project, :null => false
    t.references :language, :null => false
  end
end
