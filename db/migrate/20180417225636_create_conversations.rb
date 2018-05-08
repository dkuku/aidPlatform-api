class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :task_owner
      t.references :volunteer
      t.references :task 

      t.timestamps
    end
    add_foreign_key :conversations, :users, column: :volunteer_id, primary_key: :id
    add_foreign_key :conversations, :users, column: :task_owner_id, primary_key: :id
  end
end
