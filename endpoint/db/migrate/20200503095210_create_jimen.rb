class CreateJimen < ActiveRecord::Migration[6.0]
  def change
    create_table :jimen do |t|
      t.string :title, null: false
      t.string :description, null:false
      t.string :url, null: false
      t.string :image, null: false
      t.integer :access, null: false, default: 0
      t.integer :star, null: false, default: 0

      t.timestamps
    end
  end
end
