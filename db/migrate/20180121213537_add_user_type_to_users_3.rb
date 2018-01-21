class AddUserTypeToUsers3 < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_type, :boolean
  end
end
