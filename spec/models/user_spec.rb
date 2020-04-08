require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures email presence' do
      user = User.new(
        customer_id: 123456,
        email:       "example@example.com",
        password:    "password"
      ).save

      expect(user).to eq(true)
    end

    it 'ensures email presence' do
      user = User.new(customer_id: "123456", password: "password").save
      expect(user).to eq(false)
    end
  end
end
