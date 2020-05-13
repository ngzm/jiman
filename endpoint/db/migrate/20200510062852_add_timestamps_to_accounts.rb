class AddTimestampsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :updated_at, :timestamp
    add_column :accounts, :created_at, :timestamp
  end
end
