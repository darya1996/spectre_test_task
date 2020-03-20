require 'rails_helper'

RSpec.describe LoginsController, type: :controller do
  let(:login) {
    Login.new(
      login_id: 1,
      user_id:  1,
      status:   "Active",
      country:  "XF",
      provider: "Fake Bank Simple"
    )
  }

  let(:user) {
    User.create(
      customer_id: 1,
      email:       'test@test.com',
      password:    "password"
    )
  }

  before :each do
    sign_in user
  end

  describe "#create_login" do
    it "create a login" do
      url = "http://example.com"
      connect_response = {
        "data": {
          "connect_url": url
        }
      }.with_indifferent_access

      expect(ConnectLogin)
        .to receive(:perform).once
        .and_return(connect_response)

      post :create_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
    end
  end

  describe "#refresh_login" do
    it "refreshes a login" do
      url = "http://example.com"
      refresh_response = {
        "data": {
          "connect_url": url
        }
      }.with_indifferent_access

      expect(RefreshLogin)
        .to receive(:perform).once
        .and_return(refresh_response)

      post :refresh_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
    end
  end

  describe "#reconnect_login" do
    it "reconnect a login" do
      url = "http://example.com"
      reconnect_response = {
        "data": {
          "connect_url": url
        }
      }.with_indifferent_access

      expect(ReconnectLogin)
        .to receive(:perform).once
        .and_return(reconnect_response)

      post :reconnect_login, params: { login_id: login.login_id }

      expect(response).to redirect_to(url)
    end
  end

  # describe "#fetch_logins" do
  #   it "fetch the logins" do
  #     account_response = {
  #       "data": [
  #         {
  #           "id":            1,
  #           "name":          "First account",
  #           "nature":        "account",
  #           "balance":       "121",
  #           "currency_code": "EUR"
  #         },
  #         {
  #           "id":            2,
  #           "name":          "Second account",
  #           "nature":        "credit_card",
  #           "balance":       "-121",
  #           "currency_code": "EUR"
  #         }
  #       ]
  #     }

  #     expect(LoginsList)
  #       .to receive(:list_logins).once
  #       .and_return(account_response)

  #     # controller.send(:list).to eq([])
  #   end
  # end
end
