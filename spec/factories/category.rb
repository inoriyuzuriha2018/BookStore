FactoryBot.define do
  factory :category do
    title { Faker::Book.genre }
    description { Faker::Book.title }
  end
end