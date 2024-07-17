class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.integer :notification_timing
      t.boolean :notification_enabled
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
