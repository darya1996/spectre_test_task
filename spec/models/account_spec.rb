require 'rails_helper'

RSpec.describe Account, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validation test' do
    it 'ensures first name presence' do
      user = User.new(last_name: 'last', username: 'username', password: '123', email: 'sample@example.com').save
      expect(user).to eq(false)
    end
  end
end
