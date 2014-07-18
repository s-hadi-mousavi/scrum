class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.string :name
      t.integer :user_id
      t.integer :task_id
      t.integer :project_id
      t.integer :group_id
      t.boolean :bubble
      t.integer :flags_id

      t.timestamps
    end
  end
end
