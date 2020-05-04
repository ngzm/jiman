class CreateCategoryJimen < ActiveRecord::Migration[6.0]
  def change
    create_table :category_jimen do |t|
      t.references :category, null: false, foreign_key: true
      t.references :jiman, null: false, foreign_key: true

      t.timestamp :created_at
    end
  end
end
