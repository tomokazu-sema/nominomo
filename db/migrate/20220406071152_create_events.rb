class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :user,                        foreign_key: true
      t.string     :uid,            null: false, index: { unique: true }
      t.string     :title,          null: false
      t.string     :password_digest
      t.timestamps
    end
  end
end
