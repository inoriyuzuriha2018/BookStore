class Post < ApplicationRecord
  belongs_to :category
  enum is_public: { public: 1, unpublic: 0 },  _prefix: :is
end