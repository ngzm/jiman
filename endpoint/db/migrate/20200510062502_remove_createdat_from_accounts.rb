class RemoveCreatedatFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :Accounts, :created_at
  end
end
