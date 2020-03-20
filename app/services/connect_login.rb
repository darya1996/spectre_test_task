require 'rest-client'
require 'json'
require 'pry'

class ConnectLogin
  def self.perform(params)
    @user       = User.find(params)
    @return_url = "https://obscure-sierra-02650.herokuapp.com/success"

    response = API.request(:post, 'https://www.saltedge.com/api/v5/connect_sessions/create',
      'data' =>
        {
          'customer_id'  => "#{@user.customer_id}",
          'consent'      => consent_params,
          'attempt'      => {
            'return_to' => @return_url
          }
        }
    )

    JSON.parse(response.body)
  end

  def self.consent_params
    {
      'scopes'    => %w[account_details transactions_details],
      'from_date' => '2020-01-01'
    }
  end
end
