class LoginsController < ApplicationController
  def index
    @logins = current_user.logins
  end

  def show
    @login    = Login.find(params[:id])
    @accounts = @login.accounts
  end

  def list
    user = User.find(current_user.id)

    user_logins = Connector.list_logins(user.customer_id)

    render json: user_logins
  end

  def create_login
    response    = Connector.connect_login(current_user.id)
    connect_url = response.dig("data","connect_url")

    flash.notice = 'Login successfully created'
    redirect_to connect_url
  rescue => error
    flash.alert = token_body['error']['message']
    redirect_to logins_path
  end

  def callback_success
    save_login
    redirect_to logins_path
  end

  def save_login
    @user       = User.find(current_user.id)
    user_logins = Connector.list_logins(@user.customer_id)

    login = Login.new(
      user_id:    @user.id,
      login_id:   user_logins['data'].last['id'],
      country:    user_logins['data'].last['country_code'],
      created_at: user_logins['data'].last['created_at'],
      status:     user_logins['data'].last['status'],
      provider:   user_logins['data'].last['provider_name']
    )
    login.save

    fetch_all_accounts(login, user_logins['data'].last['id'])
  end

  def fetch_all_accounts(login, login_id)
    login.accounts.destroy_all if login.accounts.any?

    response = Connector.fetch_accounts(login_id)
    accounts = response.fetch("data")

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

      fetch_transactions(acc.id, acc.account_id, login.login_id)
    end
  end

  def fetch_transactions(acc_id, account_id, login_id)
    response     = Connector.fetch_transactions(login_id, account_id)
    transactions = response.fetch("data")

    transactions.each do |transaction|
      trans = Transaction.new(
        transaction_id: transaction['id'],
        status:         transaction['status'],
        currency:       transaction['currency_code'],
        amount:         transaction['amount'],
        description:    transaction['description'],
        made_on:        transaction['made_on'],
        category:       transaction['category'],
        account_id:     acc_id
      )
      trans.save
    end
  end

  def reconnect_login
    response    = Connector.reconnect_login(params[:login_id])
    connect_url = response.dig("data", "connect_url")

    flash.notice = 'Login successfully reconnected'
    redirect_to connect_url
  rescue => error
    flash.alert = token_body['error']['message']
    redirect_to logins_path
  end

  def refresh_login
    response    = Connector.refresh_login(params[:login_id])
    connect_url = response.dig("data", "connect_url")

    flash.notice = 'Login successfully refreshed'
    redirect_to connect_url
  rescue => error
    flash.alert = token_body['error']['message']
    redirect_to logins_path
  end

  def remove_login
    Connector.remove_login(params[:login_id])

    Login.find_by(login_id: params[:login_id]).destroy

    redirect_to logins_path
  end
end
