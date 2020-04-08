class User < ApplicationRecord
  has_many :logins

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
end
