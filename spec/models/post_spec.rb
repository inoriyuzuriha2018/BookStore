require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end
    
  describe 'validations' do

		#it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    

    it 'validates inclusion of is_public in enum values' do
			should define_enum_for(:is_public ) do
        with_values([:public, :unpublic]).with_prefix(:post)
      end
    end
  end
    
  describe 'scopes' do
    let!(:public_post) { create(:post, is_public: 'public') }
    let!(:unpublic_post) { create(:post, is_public: 'unpublic') }
    
    it 'returns only public posts' do
      expect(Post.public_posts).to include(public_post)
      expect(Post.public_posts).not_to include(unpublic_post)
    end
  end
    
  describe 'enums' do
    it 'defines enum for is_public with correct values' do
          expect(Post.is_publics).to eq({ 'public' => 1, 'unpublic' => 0 })
    end
    
    it 'sets and retrieves enum values correctly' do
          post = Post.new(title: 'Sample Post', is_public: 'public')
          expect(post.is_public).to eq('public')
          post.is_public = 'unpublic'
          expect(post.is_public).to eq('unpublic')
    end
    
    it 'uses _prefix for enum methods' do
          post = Post.new(title: 'Sample Post', is_public: 'public')
          expect(post.post_public?).to be true
          expect(post.post_unpublic?).to be false
    end
  end
end
