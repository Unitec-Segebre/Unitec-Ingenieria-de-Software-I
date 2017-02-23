class Category < ApplicationRecord
	has_many :variables
	validates :name, presence: true
	validates :name, uniqueness: true
end
