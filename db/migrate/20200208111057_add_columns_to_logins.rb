class AddColumnsToLogins < ActiveRecord::Migration[5.2]
  def change
    add_column :logins, :status, :string
    add_column :logins, :country, :string
    add_column :logins, :provider, :string
  end
end
