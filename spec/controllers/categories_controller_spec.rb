require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create(:category) }

  describe "GET #index" do
    it "Assigns @categories" do
      get :index
      expect(assigns(:categories)).to eq([category])
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested category and renders the show template" do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
      expect(response).to render_template(:show)
    end

    it "renders 404 when category is not found" do
      get :show, params: { id: 0 } # Invalid ID
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #new" do
    it "assigns a new category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new category and redirects to index" do
        post :create, params: { category: attributes_for(:category) }
        expect(flash[:success]).to eq("Category was successfully created.")

        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new category and re-renders the new template" do
        post :create, params: { category: attributes_for(:category, title: nil) }
        expect(assigns(:category).errors[:title]).to include("can't be blank")
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested category and renders the edit template" do
      get :edit, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the category and redirects to index" do
        patch :update, params: { id: category.id, category: { title: "Updated Title" } }
        category.reload
        expect(category.title).to eq("Updated Title")
        expect(flash[:success]).to eq("Category was successfully updated.")
        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the category and re-renders the edit template" do
        patch :update, params: { id: category.id, category: { title: nil } }
        expect(assigns(:category).errors[:title]).to include("can't be blank")
        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the category and redirects to index" do
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
      expect(flash[:success]).to eq("Category was successfully destroyed.")
      expect(response).to redirect_to(categories_path)
    end
  end
end
