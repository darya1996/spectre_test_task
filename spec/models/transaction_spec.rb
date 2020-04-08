require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'validation test' do
    it 'Account must exist' do
      transaction = Transaction.new(
        transaction_id: 123456,
        account_id:     123456,
        description:    "invalid transaction",
        amount:         100.0,
        currency:       "EUR"
      ).save

      expect(transaction).to eq(false)
    end
  end
end
