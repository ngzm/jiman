class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, null: false, default: 3
      t.references :user, null: false, foreign_key: true
      t.references :jiman, null: false, foreign_key: true

      t.timestamps
    end
  end
end
