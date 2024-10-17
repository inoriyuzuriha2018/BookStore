require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:cate) {create(:category)}
  let!(:postst) { create(:post, category: cate) }

  describe "GET /posts" do
    it "returns a success response and assigns @posts" do
      get :index
    
      expect(response).to be_successful
      expect(assigns(:posts)).to include(postst)
    end
  end

  describe "GET /posts/:id" do
    it "returns a success response for a valid post" do
      get :show, params: { id: postst.id }
      expect(response).to be_successful
      expect(assigns(:post)).to eq(postst)
    end

    it "renders 404 for an invalid post" do
      get :show , params: { id: -1 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /posts/new" do
    it "renders the new template" do
      get :new
      expect(response).to be_successful
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST /posts" do 
    let!(:post2) { build(:post, category: cate) }

    context "with valid parameters" do
      it "creates a new post and redirects to the index" do
        post :create, params: { post: post2.as_json }
        
        expect(response).to redirect_to(posts_path)
        expect(flash[:success]).to eq("Post was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new post and renders the new template" do
        expect {
          post :create, params: { post: attributes_for(:post, title: nil) }
        }.not_to change(Post, :count)

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET /posts/:id/edit" do
    it "renders the edit template" do
      get :edit, params: { id: postst.id}
      expect(response).to be_successful
      expect(assigns(:post)).to eq(postst)
    end
  end

  describe "PATCH /posts/:id" do
    context "with valid parameters" do
      it "updates the post and redirects to the index" do
        patch :update , params: {id: postst.id, post: { title: "Updated Title" } }
        postst.reload
        expect(postst.title).to eq("Updated Title")
        expect(response).to redirect_to(posts_path)
        expect(flash[:success]).to eq("Post was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "does not update the post and renders the edit template" do
        patch :update, params: {id: postst.id, post: { title: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "DELETE /posts/:id" do
    it "deletes the post and redirects to the index" do
      expect {
        delete :destroy, params: { id: postst.id }
      }.to change(Post, :count).by(-1)

      expect(response).to redirect_to(posts_path)
    end
  end
end
