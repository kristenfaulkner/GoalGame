class AddBodyToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :body, :string, null: false, default: ""
  end
end
