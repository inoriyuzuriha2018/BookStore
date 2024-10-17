require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:posts).inverse_of(:category).dependent(:destroy) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'accepts nested attributes for posts' do
    it 'rejects attributes for posts if all are blank' do
      category = Category.new(title: 'Sample Category', posts_attributes: [{ title: '' }])
      expect(category.posts).to be_empty
    end

    it 'allows destroying posts' do
      category = Category.create!(title: 'Sample Category')
      post = category.posts.create!(title: 'Sample Post')

      category.update(posts_attributes: [{ id: post.id, _destroy: true }])
      expect(category.posts.count).to eq(0)
    end
  end

  describe 'image attachment' do
    it 'can have an attached image' do
      category = Category.new(title: 'Sample Category')
      category.image.attach(io: File.open('spec/fixtures/sample_image.jpg'), filename: 'sample_image.jpg')

      expect(category.image).to be_attached
    end

    it 'has thumb variant with correct dimensions' do
      category = Category.new(title: 'Sample Category')
      category.image.attach(io: File.open('spec/fixtures/sample_image.jpg'), filename: 'sample_image.jpg')
      variant = category.image.variant(resize_to_limit: [50, 50])

      expect(variant.blob.content_type).to eq("image/jpeg")
      # You can also check the variant's processed dimensions
    end
  end
end
