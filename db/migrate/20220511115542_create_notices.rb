class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.references :event, null: false, foreign_key: true
      t.text       :message
      t.timestamps
    end
  end
end
