class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    user = params[:user]["email"]

    CreateCustomer.new.perform(user)
  end
end
