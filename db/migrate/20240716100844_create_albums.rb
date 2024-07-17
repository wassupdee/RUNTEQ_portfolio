class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.date :date
      t.string :title
      t.text :diary
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
