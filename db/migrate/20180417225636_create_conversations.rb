class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :volunteer, foreign_key:{ to_table: :users}
      t.references :task_owner, foreign_key:{ to_table: :users}
      t.references :task 

      t.timestamps
    end
  end
end
