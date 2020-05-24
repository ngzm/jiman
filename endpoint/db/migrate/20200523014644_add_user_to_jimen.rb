class AddUserToJimen < ActiveRecord::Migration[6.0]
  def change
    add_reference :jimen, :user, foreign_key: true, null: false, default: 1
  end
end
