require 'rest-client'
require 'json'

class RefreshLogin
  def perform(login_id)
    @login_id   = login_id
    @return_url = "http://localhost:3000/success"

    connect
  end

  def connect
    API.request(:post, "https://www.saltedge.com/api/v5/connect_sessions/refresh",
       'data' => {
        'connection_id' => @login_id,
        'attempt'       => {
            'return_to' => @return_url
        }
      })
  end
end
