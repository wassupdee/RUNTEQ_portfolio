class AddLastContactedAndNoteToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :last_contacted, :integer
    add_column :profiles, :note, :text
  end
end
