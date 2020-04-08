require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validation test' do
    it 'Login must exist' do
      account = Account.new(account_id: 12345, name: "test_account", login_id: 12345).save

      expect(account).to eq(false)
    end
  end
end
