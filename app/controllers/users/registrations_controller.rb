class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    email = params[:user]["email"]
    user = User.find_by(email: email)

    response = Connector.create_customer(email)
    customer_id = response.dig("data", "id")
    user.customer_id = customer_id
    user.save
  end
end
