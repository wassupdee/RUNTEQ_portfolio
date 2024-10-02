class AddGroupIdToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_reference :profiles, :group, foreign_key: true
  end
end
