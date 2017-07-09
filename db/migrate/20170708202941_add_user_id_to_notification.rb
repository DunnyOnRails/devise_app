class AddUserIdToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :user_id, :string
  end
end
