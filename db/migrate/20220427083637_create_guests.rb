class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.references :event, null: false, foreign_key: true
      t.string     :name,  null: false
      t.text       :comment
      t.timestamps
    end
  end
end
