class ChangeIdToBeStringInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :id, :string
  end
end
