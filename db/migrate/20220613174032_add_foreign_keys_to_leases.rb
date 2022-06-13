class AddForeignKeysToLeases < ActiveRecord::Migration[6.1]
  def change
    change_table :leases do |t|
      t.integer :tenant_id
      t.integer :apartment_id
    end
  end
end
