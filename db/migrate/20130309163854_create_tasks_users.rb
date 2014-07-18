class CreateTasksUsers < ActiveRecord::Migration
  create_table :tasks_users, :id => false do |t|
    t.references :user, :null => false
    t.references :task, :null => false
  end
end
