class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :number, null: false
    end
  end
end
