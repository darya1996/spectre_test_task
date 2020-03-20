require 'rest-client'
require 'json'
require 'pry'

class LoginsList
  def self.list_logins(user_id)
    user = User.find(user_id)
    user_logins = API.request(:get, 'https://www.saltedge.com/api/v5/connections/', { 'data' => {'customer_id' => user.customer_id } })

    JSON.parse user_logins.body
  end
end
