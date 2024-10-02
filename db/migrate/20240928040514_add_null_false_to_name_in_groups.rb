class AddNullFalseToNameInGroups < ActiveRecord::Migration[7.1]
  def change
    change_column :groups, :name, :string, null: false
  end
end
