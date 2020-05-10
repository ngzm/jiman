class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :provider, null: false
      t.string :identifier, null: false
      t.string :access_token, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamp :created_at
    end
  end
end
