class CreateGroupsUsers < ActiveRecord::Migration
  create_table :groups_users, :id => false do |t|
    t.references :user, :null => false
    t.references :group, :null => false
  end
end
