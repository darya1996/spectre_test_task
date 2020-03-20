class ChangeIntegerLimitInLogins < ActiveRecord::Migration[5.2]
  def change
    change_column :logins, :login_id, :integer, limit: 8
  end
end
