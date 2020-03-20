require 'rest-client'
require 'json'
require 'pry'

class RefreshLogin
  def self.perform(login_id)
    @login_id   = login_id
    @return_url = "https://obscure-sierra-02650.herokuapp.com/success"

    response = API.request(:post, "https://www.saltedge.com/api/v5/connect_sessions/refresh",
       'data' => {
        'connection_id' => @login_id,
        'attempt'       => {
            'return_to' => @return_url
        }
      })

     response.class == Hash ? response : JSON.parse(response.body)
  end
end
