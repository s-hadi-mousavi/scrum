class CreateTrequests < ActiveRecord::Migration
  def change
    create_table :trequests do |t|
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
