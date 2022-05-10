class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :possible_date, null: false, foreign_key: true
      t.references :guest,         null: false, foreign_key: true
      t.integer    :answer_id
      t.timestamps
    end
  end
end
