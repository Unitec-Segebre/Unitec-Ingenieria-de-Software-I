class Project < ApplicationRecord
  validates :title, presence: true
  has_many :lots
  mount_uploader :image, ImageUploader
  
  def get_image
  	if self.image_url.blank?
  		"project_example.jpeg"
  	else
  		self.image_url
  	end
  end
end
