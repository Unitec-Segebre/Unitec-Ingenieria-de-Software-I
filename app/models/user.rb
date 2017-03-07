class User < ApplicationRecord
  has_secure_password
  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true

end
