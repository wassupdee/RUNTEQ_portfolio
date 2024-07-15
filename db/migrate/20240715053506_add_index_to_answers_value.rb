class AddIndexToAnswersValue < ActiveRecord::Migration[7.1]
  def change
    add_index :answers, :value, unique: true
  end
end
