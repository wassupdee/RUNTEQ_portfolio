class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :furigana
      t.string :phone
      t.string :email
      t.string :line_name
      t.string :birthplace
      t.string :address
      t.string :occupation

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
