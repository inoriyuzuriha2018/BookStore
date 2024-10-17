FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    description { Faker::String.random }
    is_public { :public }
    association :category 

    after(:build) do |post|
      post.category ||= FactoryBot.create(:category) # Creates a category if none is given
    end

    after(:create) do |post|
      post.category ||= FactoryBot.create(:category) # Creates a category if none is given
    end
  end
end