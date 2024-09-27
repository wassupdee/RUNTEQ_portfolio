class RemoveGroupIdFromProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :group_id
  end
end
