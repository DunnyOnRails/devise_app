class RenameUsernameToUserId < ActiveRecord::Migration[5.0]
  def change
        rename_column :profiles, :username, :user_id
  end
end
