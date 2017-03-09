class User < ApplicationRecord
  has_secure_password
  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true

  mount_uploader :image, ImageUploader

  def get_image
    if self.image.blank?
      "user_default.png"
    else
      self.image
    end
  end
end
