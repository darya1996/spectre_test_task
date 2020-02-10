class ChangeIntegerLimitInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :transaction_id, :integer, limit: 8
  end
end
