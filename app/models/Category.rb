class Category < ApplicationRecord
  has_many :posts, inverse_of: :category, dependent: :destroy
  has_one_attached :image do | attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end
  accepts_nested_attributes_for :posts, reject_if: :all_blank, allow_destroy: true

  validates :title, length: { maximum: 255 }, presence: true, uniqueness: true, allow_blank: false
end