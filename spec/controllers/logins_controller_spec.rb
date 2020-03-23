require 'rails_helper'

RSpec.describe LoginsController, type: :controller do
  let(:login) {
    Login.new(
      login_id: 1,
      user_id:  1,
      status:   "Active",
      country:  "XF",
      provider: "Fake Bank Simple",
      accounts: [account]
    )
  }

  let(:user) {
    User.create(
      id:          1,
      customer_id: 1,
      email:       'test@test.com',
      password:    "password",
      logins:      [login]
    )
  }

  let(:transaction) {
    Transaction.new(
      id:         1,
      account_id: 1
    )
  }

  let(:account) {
    Account.new(
      id:            1,
      login_id:      1,
      transactions:  [transaction]
    )
  }

  before :each do
    sign_in user
  end

  describe "#create_login" do
    it "create a login" do
      url = "http://example.com"
      connect_response = {
        "data" => {
          "connect_url" => url
        }
      }.with_indifferent_access

      expect(Connector)
        .to receive(:connect_login).once
        .and_return(connect_response)

      post :create_login

      expect(response).to redirect_to(url)
    end
  end

  describe "#refresh_login" do
    it "refreshes a login" do
      url = "http://example.com"
      refresh_response = {
        "data" => {
          "connect_url" => url
        }
      }.with_indifferent_access

      expect(Connector)
        .to receive(:refresh_login).once
        .and_return(refresh_response)

      post :refresh_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
    end

    it "handles error" do
      url       = "http://example.com"
      login_url = "http://example.com/logins"

      refresh_response = {
        "error": {
          "message": "Connection cannot be refreshed"
        },
        "next_refresh_possible_at": "2020-03-23 15:19:38"
      }

      error = RestClient::NotAcceptable.new(
        RestClient::Exception.new(double( body: refresh_response.to_json, http_headers: { location: url } ))
      )

      expect(Connector)
        .to receive(:refresh_login).once
        .and_raise(error)

      post :refresh_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(login_url)
    end
  end

  describe "#reconnect_login" do
    it "reconnect a login" do
      url = "http://example.com"
      reconnect_response = {
        "data" => {
          "connect_url" => url
        }
      }

      expect(Connector)
        .to receive(:reconnect_login).once.and_return(reconnect_response)

      post :reconnect_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
    end
  end

  # describe "#fetch_logins" do
  #   it "fetch the logins" do
  #     account1 = {
  #       "data"=> [
  #         {
  #           "id"            => 1,
  #           "name"          => "First account",
  #           "nature"        => "account",
  #           "balance"       => "121",
  #           "currency_code" => "EUR",
  #           "extra"         => {
  #             "transactions_count" => {
  #               "posted" => 2,
  #               "pending" => 0
  #             }
  #           }
  #         }
  #       ]
  #     }

  #     transaction1 = {
  #       "data" => [
  #         {
  #           "id"            => 1,
  #           "description"   => "transaction",
  #           "status"        => "booked",
  #           "amount"        => "5",
  #           "currency_code" => "USD",
  #           "made_on"       => "2019-10-10"
  #         }
  #       ]
  #     }

  #     transaction2 = {
  #       "data" => [
  #         {
  #           "id"            => 2,
  #           "description"   => "card transaction",
  #           "status"        => "booked",
  #           "amount"        => "10",
  #           "currency_code" => "USD",
  #           "made_on"       => "2019-10-9"
  #         }
  #       ]
  #     }

  #     expect(Connector)
  #       .to receive(:fetch_accounts).once.and_return(account1)

  #     expect(Connector)
  #       .to receive(:fetch_transactions)
  #       .with(login.login_id, account1["data"].first["id"])
  #       .and_return(transaction1)

  #     expect(Connector)
  #       .to receive(:fetch_transactions)
  #       .with(login.login_id, account1["data"].first["id"])
  #       .and_return(transaction2)

  #     expect {
  #       controller.send(:fetch_all_accounts, login, login.login_id)
  #     }.to change { login.accounts.count }.by (+2)
  #   end
  # end
end
