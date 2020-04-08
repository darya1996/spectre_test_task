require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:login) {
    Login.new(
      id:       1,
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
      id:          9999,
      customer_id: 1,
      email:       "test@test.com",
      password:    "password",
      logins:      [login]
    )
  }

  let(:account) {
    Account.new(
      id:       1,
      login_id: 1,
      name:     "test_account"
    )
  }

  before :each do
    sign_in user

    allow(Login)
      .to receive(:where)
      .and_return(login)

    allow_any_instance_of(Login)
      .to receive(:save!)
      .and_return(true)
  end

  describe "#create_login" do
    it "create a login" do
      account1 = {
        "data"=> [
          {
            "id"            => 1,
            "name"          => "First account",
            "nature"        => "account",
            "balance"       => "121",
            "currency_code" => "EUR",
            "extra"         => {
              "transactions_count" => {
                "posted" => 2,
                "pending" => 0
              }
            }
          }
        ]
      }

      url = "http://example_login.com"

      expect(Connector)
        .to receive(:fetch_accounts)
        .with(login.login_id)
        .and_return(account1)

      get :fetch, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
      expect(login.accounts.length).to eq(1)
    end
  end
end
