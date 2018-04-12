class AddTypeToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :task_type, :string
    add_column :tasks, :status, :boolean
  end
end
