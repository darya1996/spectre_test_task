require 'rest-client'
require 'json'

class RemoveLogin
  def perform(login_id)
    @login_id = login_id
    API.request(:delete, "https://www.saltedge.com/api/v5/connections/#{@login_id}")
  end
end
