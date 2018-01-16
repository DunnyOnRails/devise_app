class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :profiles, :user_image, :avatar
  end
end
