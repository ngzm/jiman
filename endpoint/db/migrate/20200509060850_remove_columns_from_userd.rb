class RemoveColumnsFromUserd < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :provider, :string

    remove_column :users, :identifer, :string
  end
end
