class DropGroupsProfiles < ActiveRecord::Migration[7.1]
  def change
    drop_table :groups_profiles
  end
end
