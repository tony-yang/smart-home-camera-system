class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_users do |t|
      t.string :username, :null => false
      t.string :password_digest, => false
      t.timestamps
      add_index :username
    end
  end
end
