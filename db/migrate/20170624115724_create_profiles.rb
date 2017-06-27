class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :user_image
      t.string :company_name
      t.string :main_email
      t.string :main_phone
      t.string :office_phone
      t.string :one_line_address

      t.timestamps
    end
  end
end
