class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :full_name
      t.string :email
      t.string :image
      t.string :provider
      t.string :identifer
      t.boolean :admin, null: false, default: false

      t.timestamps
    end
  end
end
