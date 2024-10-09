class Category < ApplicationRecord
  has_many :posts, inverse_of: :category, dependent: :destroy
  has_one_attached :image do | attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end
  accepts_nested_attributes_for :posts, reject_if: :all_blank, allow_destroy: true

  validates :title, length: { maximum: 255 }, presence: true, uniqueness: true, allow_blank: false
  validates :description, length: { minimum: 2 }
  before_validation :image_type
 
  def image_type
    type =  !image.content_type.blank? ? image.content_type : ""
    if image.attached? == false
      errors.add(:image, "is missing")
    end
    if !type.in?(%('image/jpeg image/png'))
      errors.add(:image, "needs to be a jpeg or png")
    end
  end
end