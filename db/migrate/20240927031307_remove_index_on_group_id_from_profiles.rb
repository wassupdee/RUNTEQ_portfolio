class RemoveIndexOnGroupIdFromProfiles < ActiveRecord::Migration[7.1]
  if index_exists?(:profiles, :group_id)
    remove_index :profiles, :group_id
  else
    puts "Index does not exist, skipping migration."
  end
end
