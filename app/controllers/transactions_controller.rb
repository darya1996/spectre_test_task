class TransactionsController < ApplicationController
  def fetch
    account = Account.find(params[:id])

    Lists::TransactionsLists.new.fetch(params[:id])
    redirect_to account
  end
end
