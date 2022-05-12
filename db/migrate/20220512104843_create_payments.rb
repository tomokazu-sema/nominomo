class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :guest,              null: false, foreign_key: true
      t.references :payment_management, null: false, foreign_key: true
      t.string     :price
      t.integer    :status_id
      t.timestamps
    end
  end
end
