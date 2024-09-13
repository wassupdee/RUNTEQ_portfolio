class RemoveBirthplaceOccupationContactedFromProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :profiles, :birthplace, :string
    remove_column :profiles, :occupation, :string
    remove_column :profiles, :contacted, :string
  end
end
