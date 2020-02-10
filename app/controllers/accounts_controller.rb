class AccountsController < ApplicationController
  def fetch
    login = Login.find_by(login_id: params[:login_id])

    FetchAccounts.new.fetch(params[:login_id])
    redirect_to login
  end

  def show
    @account      = Account.find(params[:id])
    @transactions = @account.transactions
  end
end
