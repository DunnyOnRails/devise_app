class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :title
      t.text :content
      t.boolean :visible

      t.timestamps
    end
  end
end
