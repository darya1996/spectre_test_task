require 'rest-client'
require 'json'
require 'pry'

class ConnectLogin
  def perform(params)
    @user       = User.find(params)
    @return_url = "https://secure-headland-50598.herokuapp.com/success"

    connect
  end

  def connect
    token = API.request(:post, 'https://www.saltedge.com/api/v4/tokens/create/',
      'data' =>
        {
          'customer_id'  => "#{@user.customer_id}",
          'return_to'    => @return_url,
          'fetch_scopes' => %w[accounts transactions]
        }
    )

    token_body  = JSON.parse(token.body)
    token_body['data']['connect_url']
  end
end
