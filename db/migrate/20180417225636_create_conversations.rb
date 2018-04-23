class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :volunteer
      t.references :task_owner
      t.references :task 

      t.timestamps
    end
  end
end
