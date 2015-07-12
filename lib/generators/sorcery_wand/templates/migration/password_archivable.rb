class SorceryWandPasswordArchivable < ActiveRecord::Migration
  def change
    create_table :password_archives do |t|
      t.string :crypted_password
      t.string :salt
      t.string :<%= options[:model_name].tableize.singularize %>_id

      t.timestamps null: false
    end
  end
end
