require 'rest-client'
require 'json'
require 'pry'

class ReconnectLogin
  def self.perform(login_id)
    @login_id   = login_id
    @return_url = "https://obscure-sierra-02650.herokuapp.com/success"

    response = API.request(:post, "https://www.saltedge.com/api/v5/connect_sessions/reconnect",
       'data' =>
        {
          'connection_id' => @login_id,
          'consent'       => consent_params,
          'attempt'       => {
            'return_to' => @return_url
          }
        }
    )

    JSON.parse(response.body)
  end

  def self.consent_params
    {
      'period_days' => 90,
      'scopes'      => %w[account_details transactions_details]
    }
  end
end
