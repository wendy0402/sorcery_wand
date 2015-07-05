class SorceryPasswordArchivable < ActiveRecord::Migration
  def change
    create_table :password_archive do |t|
      t.string :id,            :null => false
      t.string :crypted_password
      t.string :salt,
      t.string :<%= options[:model_name].tableize.singularize %>_id
      
      t.timestamps
    end
  end
end