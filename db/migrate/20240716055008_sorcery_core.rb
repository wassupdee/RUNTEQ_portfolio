class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,                 null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :first_name,            null: false
      t.string :last_name,             null: false
      t.string :line_user_id,                       index: { unique: true }
      t.boolean :notification_enabled, null: false, default: true

      t.timestamps                     null: false
    end
  end
end
