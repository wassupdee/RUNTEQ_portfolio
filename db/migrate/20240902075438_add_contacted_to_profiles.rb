class AddContactedToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :contacted, :boolean, null: false, default: false
  end
end
