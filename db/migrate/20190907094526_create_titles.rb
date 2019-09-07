class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :due_date, null: false
      t.integer :priority, null: false
      t.boolean :complete, null: false, default: false
    
      t.timestamps
    end
  end
end
