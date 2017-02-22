class Category < ApplicationRecord
	has_many :variables
	validates :name, presence: true
end
