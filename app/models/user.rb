class User < ApplicationRecord
  has_secure_password
  validates :username, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

end
