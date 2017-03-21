class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_users do |t|
      t.string :username, :null => false
      t.string :password_digest, :null => false
      t.timestamps
    end
    add_index :admin_users, :username
  end
end
