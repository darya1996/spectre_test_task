class LoginsController < ApplicationController
  def index
    @logins = current_user.logins
  end

  def show
    @login    = Login.find(params[:id])
    @accounts = @login.accounts
  end

  def list
    user_logins = LoginsList.new.list_logins(current_user.id)
    render json: user_logins
  end

  def create_login
    token = ConnectLogin.new.perform(current_user.id)

    token_body  = JSON.parse(token.body)
    connect_url = token_body['data']['connect_url']

    flash.notice = 'Login successfully created'
    redirect_to connect_url
  rescue => error
    flash.alert = token["error"]["message"]
    redirect_to logins_path
  end

  def callback_success
    save_login
    redirect_to logins_path
  end

  def save_login
    SaveLogin.new.perform(current_user.id)
  end

  def reconnect_login
    token = ReconnectLogin.new.perform(params[:login_id])

    token_body  = JSON.parse(token.body)
    connect_url = token_body['data']['connect_url']

    flash.notice = 'Login successfully reconnected'
    redirect_to connect_url
  rescue => error
    flash.alert = token["error"]["message"]
    redirect_to logins_path
  end

  def refresh_login
    token = RefreshLogin.new.perform(params[:login_id])

    token_body   = JSON.parse(token.body)
    connect_url  = token_body['data']['connect_url']

    flash.notice = 'Login successfully refreshed'
    redirect_to connect_url
  rescue => error
    flash.alert = token["error"]["message"]
    redirect_to logins_path
  end

  def remove_login
    RemoveLogin.new.perform(params[:login_id])

    Login.find_by(login_id: params[:login_id]).destroy

    redirect_to logins_path
  end
end
