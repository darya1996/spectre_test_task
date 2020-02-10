class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.string :status
      t.string :currency
      t.float :amount
      t.string :description
      t.string :made_on
      t.string :category
      t.string :mode
      t.belongs_to :account, foreign_key: "account_id"

      t.timestamps
    end
  end
end
