require 'rails_helper'

RSpec.describe Login, type: :model do
  context 'validation test' do
    it 'User must exist' do
      login = Login.new(
        login_id: 123456,
        user_id:  123456,
        provider: "Fake Bank Simple",
        country:  "XF"
      ).save

      expect(login).to eq(false)
    end
  end
end
