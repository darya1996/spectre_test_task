class ChangeIntegerLimitInAccounts < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :customer_id, :integer, limit: 8
  end
end
