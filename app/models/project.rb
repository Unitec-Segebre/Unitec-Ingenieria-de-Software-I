class Project < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  has_many :lots
  mount_uploader :image, ImageUploader

  def get_image
  	if self.image.blank?
  		"project_example.jpeg"
  	else
  		self.image
  	end
  end
end
