class CreateGroupsProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :groups_profiles do |t|
      t.references :group, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
