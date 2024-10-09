class Post < ApplicationRecord
  belongs_to :category
  enum is_public: { public: 1, unpublic: 0 },  _prefix: :post

  validates :title, length: { maximum: 255 }, presence: true, uniqueness: true, allow_blank: false
  validates :is_public, inclusion: { in: self.is_publics.keys }
  validates :description, length: { minimum: 1 }
end