class CreateLanguagesTasks < ActiveRecord::Migration
  create_table :languages_tasks, :id => false do |t|
    t.references :task, :null => false
    t.references :language, :null => false
  end
end
