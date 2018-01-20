class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.integer :topics_count
      t.integer :posts_count
      t.boolean :locked

      t.timestamps
    end
  end
end
