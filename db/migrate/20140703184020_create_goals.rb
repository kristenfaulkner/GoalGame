class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.boolean :private, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
