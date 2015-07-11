class SorceryWandPasswordArchivable < ActiveRecord::Migration
  def change
    create_table :password_archives do |t|
      t.string :crypted_password
      t.string :salt
      t.string :user_id

      t.timestamps null: false
    end
  end
end
