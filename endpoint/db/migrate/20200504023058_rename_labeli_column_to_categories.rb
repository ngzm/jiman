class RenameLabeliColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :labeli, :name
  end
end
