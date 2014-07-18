class CreateGroupJoinTables < ActiveRecord::Migration
  def change
    create_table :groups_mods, :id => false do |t|
      t.references :group, :null => false
      t.references :user, :null => false
    end
    create_table :groups_members, :id => false do |t|
      t.references :group, :null => false
      t.references :user, :null => false
    end
    add_index :groups_members, [ :group_id, :user_id ], :unique => true, :name => 'by_group_and_member'
    add_index :groups_mods, [ :group_id, :user_id ], :unique => true, :name => 'by_group_and_mod'
  end
end
