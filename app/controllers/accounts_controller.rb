class AccountsController < ApplicationController
  def fetch
    login = Login.find_by(login_id: params[:login_id])

    login.accounts.destroy_all if login.accounts.any?
    response = Connector.fetch_accounts(login_id)

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

      fetch_transactions(acc_id, login.login_id)
    end
    redirect_to login
  end

  def show
    @account      = Account.find(params[:id])
    @transactions = @account.transactions
  end
end
