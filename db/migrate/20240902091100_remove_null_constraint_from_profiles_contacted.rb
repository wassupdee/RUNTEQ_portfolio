class RemoveNullConstraintFromProfilesContacted < ActiveRecord::Migration[7.1]
  def change
    change_column_null :profiles, :contacted, true
  end
end
