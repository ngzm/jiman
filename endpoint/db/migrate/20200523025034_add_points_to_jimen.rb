class AddPointsToJimen < ActiveRecord::Migration[6.0]
  def change
    add_column :jimen, :point1, :string
    add_column :jimen, :point2, :string
    add_column :jimen, :point3, :string
    add_column :jimen, :point4, :string
    add_column :jimen, :point5, :string
    add_column :jimen, :point6, :string
  end
end
