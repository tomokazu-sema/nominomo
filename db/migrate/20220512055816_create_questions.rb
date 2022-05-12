class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :event,   null: false, foreign_key: true
      t.string     :title,   null: false
      t.text       :content
      t.timestamps
    end
  end
end
