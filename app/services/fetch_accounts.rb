require 'lists/transactions_lists'
require 'rest-client'
require 'json'
require 'pry'

class FetchAccounts
  def fetch(login_id)
    login = Login.find_by(login_id: login_id)

    login.accounts.destroy_all if login.accounts.any?
    response = API.request(:get, 'https://www.saltedge.com/api/v4/accounts',
      'data' =>
        {
          'login_id'    => login_id,
          'customer_id' => login.user.customer_id
        }
    )

    accounts = JSON.parse response.body
    accounts = accounts['data']

    accounts.each do |account|
      transactions_posted  = account['extra']['transactions_count']['posted'].to_i
      transactions_pending = account['extra']['transactions_count']['pending'].to_i

      acc = Account.new(
        account_id:         account['id'],
        login_id:           login.id,
        name:               account['name'],
        balance:            account['balance'],
        currency:           account['currency_code'],
        nature:             account['nature'],
        transactions_count: transactions_posted + transactions_pending
      )

      acc.save
      Lists::TransactionsLists.new.fetch(acc.id)
    end
  end
end
