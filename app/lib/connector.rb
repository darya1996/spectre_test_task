require 'rest-client'
require 'json'
require 'pry'

class Connector
  def self.list_logins(customer_id)
    get("/connections?customer_id=#{customer_id}")
  end

  def self.create_customer(email)
    post('/customers', { 'data' => { 'identifier' => email } })
  end

  def self.connect_login(params)
    user       = User.find(params)
    return_url = 'https://obscure-sierra-02650.herokuapp.com/success'

    post(
      '/connect_sessions/create',
      {
        'data' => {
          'customer_id' => user.customer_id,
          'consent'     => consent_params,
          'attempt'     => {
            'return_to' => return_url
          }
        }
      }
    )
  end

  def self.consent_params
    {
      'scopes'    => %w[account_details transactions_details],
      'from_date' => '2020-01-01'
    }
  end

  def self.fetch_accounts(login_id)
    login = Login.find_by(login_id: login_id)

    get("/accounts?connection_id=#{login_id}&customer_id=#{login.user.customer_id}")
  end

  def self.fetch_transactions(connection_id, account_id)
    get("/transactions?connection_id=#{connection_id}&account_id=#{account_id}")
  end

  def self.reconnect_login(login_id)
    return_url = 'https://obscure-sierra-02650.herokuapp.com/success'

    post(
      '/connect_sessions/reconnect',
      {
        'data' => {
          'connection_id' => login_id,
          'consent' => {
            'scopes' => %w[account_details transactions_details]
          },
          'attempt' => {
            'fetch_scopes' => %w[accounts transactions],
            'return_to'    => return_url
          }
        }
      }
    )
  end

  def self.refresh_login(login_id)
    put(
      "/connections/#{login_id}/refresh",
      {
        'data' => {
          'attempt' => {
            'fetch_scopes' => %w[accounts transactions]
          }
        }
      }
    )
  end

  def self.remove_login(login_id)
    delete("/connections/#{login_id}")
  end

  def self.get(url, payload={})
    request(method: :get, url: url, payload: payload)
  end

  def self.post(url, payload={})
    request(method: :post, url: url, payload: payload)
  end

  def self.put(url, payload={})
    request(method: :put, url: url, payload: payload)
  end

  def self.delete(url, payload={})
    request(method: :delete, url: url, payload: payload)
  end

  def self.request(options)
    response = RestClient::Request.execute(
      method:  options[:method],
      url:     Settings.base_url + options[:url],
      headers: {
        "Accept":       "application/json",
        "Content-type": "application/json",
        "App-id":       Settings.application.app_id,
        "Secret":       Settings.application.secret
      },
      payload: options[:payload].to_json
    )

    JSON.parse(response.body)
  rescue => error
    raise error
  end
end
