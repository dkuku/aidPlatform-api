class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :status, :done
  end
end
