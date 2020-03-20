class ChangeIntegerLimitForIdInAccounts < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :account_id, :integer, limit: 8
  end
end
