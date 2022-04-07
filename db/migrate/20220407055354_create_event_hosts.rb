class CreateEventHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :event_hosts do |t|
      t.references :event, null: false, foreign_key: true
      t.string     :uid,   null: false, index: { unique: true }
      t.timestamps
    end
  end
end
