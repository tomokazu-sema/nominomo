class CreatePossibleDates < ActiveRecord::Migration[7.0]
  def change
    create_table :possible_dates do |t|
      t.references :event, null: false, foreign_key: true
      t.date       :date,  null: false
      t.timestamps
    end
  end
end
