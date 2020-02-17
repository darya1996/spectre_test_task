require 'rest-client'
require 'json'
require 'pry'

module Lists
  class TransactionsLists
    def fetch(account_id, connection_id)
      account  = Account.find(account_id)
      response = API.request(:get, "https://www.saltedge.com/api/v5/transactions?connection_id=#{connection_id}&account_id=#{account.account_id}")
      transactions = JSON.parse response.body

      transactions = transactions['data']

      transactions.each do |transaction|
        trans = Transaction.new(
          transaction_id: transaction['id'],
          status: transaction['status'],
          currency: transaction['currency_code'],
          amount: transaction['amount'],
          description: transaction['description'],
          made_on: transaction['made_on'],
          category: transaction['category'],
          account_id: account.id
        )
        trans.save
      end
    end
  end
end
