class AddHandleToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :handle, :string
  end
end
