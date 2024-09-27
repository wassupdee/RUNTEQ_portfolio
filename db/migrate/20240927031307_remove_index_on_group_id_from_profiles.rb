class RemoveIndexOnGroupIdFromProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_index :profiles, :group_id
  end
end
