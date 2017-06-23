class AddItemsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :agreed_terms, :boolean, default: false
    add_column :users, :agreed_subscribe, :boolean, default: false
  end
end
