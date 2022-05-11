class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.references :event, null: false, foreign_key: true
      t.string     :place, null: false
      t.string     :url
      t.text       :comment
      t.timestamps
    end
  end
end
