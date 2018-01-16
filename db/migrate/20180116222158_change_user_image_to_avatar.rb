class ChangeUserImageToAvatar < ActiveRecord::Migration[5.0]
  def change
    rename_column :profiles, :avatar, :user_image
  end
end
