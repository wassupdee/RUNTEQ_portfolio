class RemoveGroupIdFromProfiles < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:profiles, :group_id)
      remove_column :profiles, :group_id
    else
      puts "group_id column does not exist, skipping removal."
    end
end
