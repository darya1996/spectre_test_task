require 'rest-client'
require 'json'
require 'pry'

class ReconnectLogin
  def perform(login_id)
    @login_id   = login_id
    @return_url = "http://localhost:3000/success"

    connect
  end

  def connect
    API.request(:post, "https://www.saltedge.com/api/v5/connect_sessions/reconnect",
       'data' =>
        {
          'connection_id' => @login_id,
          'consent'       => consent_params,
          'attempt'       => {
            'return_to' => @return_url
          }
        }
    )
  end

  def consent_params
    {
      'period_days' => 90,
      'scopes'      => %w[account_details transactions_details]
    }
  end
end
