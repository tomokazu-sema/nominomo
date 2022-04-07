class RenameEncryptedPasswordColumnToEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :encrypted_password, :password_digest
  end
end
