class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :text, null: false
      t.string :value, null: false
      t.integer :number, null: false
      t.references :question, null: false, foreign_key: true
    end
  end
end
