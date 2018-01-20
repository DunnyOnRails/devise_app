class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.text :content
      t.boolean :locked
      t.belongs_to :subject, foreign_key: true
      # t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
