class Category < ApplicationRecord
	has_many :variables, :dependent => :delete_all
	validates :name, presence: true
	validates :name, uniqueness: true
end
