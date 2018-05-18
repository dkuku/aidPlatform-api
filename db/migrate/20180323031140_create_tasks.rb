class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.decimal :lat
      t.decimal :lng
      t.integer :done, default: 0
      t.string :task_type 
      t.integer :fulfilment_counter, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
