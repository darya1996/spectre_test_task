RSpec.describe LoginsController do
  let(:consent_params) {
    {
      'scopes'    => %w[account_details transactions_details],
      'from_date' => '2020-01-01'
    }
  }
  let(:params) {
    {
      'customer_id'  => 10541329,
      'consent'      => consent_params,
      'attempt'      => {
        'return_to' => "http://localhost:3000/success"
      }
    }
  }

  describe "POST #create_login" do
    it "creates new login" do
      stub_request(:post, "https://www.saltedge.com/api/v5/connect_sessions/create").with(body: { data: params })
      RestClient.post()
    end
  end
end
