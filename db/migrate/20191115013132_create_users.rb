class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.string :name
      t.string :password_confirmation
    end
  end
end
