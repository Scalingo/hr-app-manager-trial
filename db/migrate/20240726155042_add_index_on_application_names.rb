class AddIndexOnApplicationNames < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_index :applications, :name, unique: true, algorithm: :concurrently
  end
end
