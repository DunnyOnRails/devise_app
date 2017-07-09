class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.boolean :allow_emailmsg
      t.boolean :allow_smsmsg
      t.boolean :allow_socialmsg
      t.boolean :allow_webmsg
      t.boolean :allow_post

      t.timestamps
    end
  end
end
