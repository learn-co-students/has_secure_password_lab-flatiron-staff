class RemoveColsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :password_confirmation
    add_column :users, :password_digest, :string
  end
end
