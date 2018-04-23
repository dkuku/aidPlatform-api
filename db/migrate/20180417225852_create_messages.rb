class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :volunteer, references: :user
      t.references :task_owner, references: :user
      t.references :task, index: true
      t.boolean :owner, :default => false
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end
